require "ffi-icu"

class BreweriesController < ApplicationController
  def index
  	@breweries = Brewery.all

  	collator = ICU::Collation::Collator.new("pl_PL")

  	@breweries.sort! { |a, b| collator.compare(a.nazwa, b.nazwa)}

  	@breweries.each { |brewery| 
  		brewery.beer_count = Beer.find(:all, :conditions => "brewery_id =" + brewery.id.to_s).count
      brewery.country = Beer.find(:last,  :conditions => [ "brewery_id = ?", brewery.id ])
  	}

    @breweries = @breweries[params[:page].to_i*25..((params[:page].to_i+1)*25-1)]

    @breweries_paginate = Brewery.page(params[:page])
  end

  def show
  	@brewery = Brewery.find(params[:id])
  	@beers = Beer.find(:all, :conditions => "brewery_id = " + @brewery.id.to_s)
  end

  def edit
      @brewery = Brewery.find(params[:id])
  end

  def update
    @brewery = Brewery.find(params[:id])

    if @brewery.update_attributes(params[:brewery])
      redirect_to @brewery
    else
      render 'edit'
    end
  end

  def destroy
    @brewery = Brewery.find(params[:id])
    @brewery.destroy
 
    redirect_to breweries_path
  end

  def autocomplete
    @breweries = Brewery.where("nazwa LIKE ?", "%"+params[:term]+"%")

    resp = Array.new

    @breweries.each { |brewery|
      resp.push ({ "id" => brewery.id, "label" => brewery.nazwa, "value" => brewery.nazwa})
    }

    render json: resp
  end
end
