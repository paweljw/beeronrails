require "ffi-icu"

class BreweriesController < ApplicationController
  def index
  	@breweries = Brewery.all

  	collator = ICU::Collation::Collator.new("pl_PL")

  	@breweries.sort! { |a, b| collator.compare(a.nazwa, b.nazwa)}

  	@breweries.each { |brewery| 
  		brewery.beer_count = Beer.find(:all, :conditions => "brewery_id =" + brewery.id.to_s).count
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
end
