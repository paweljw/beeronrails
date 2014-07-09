require "ffi-icu"

class BreweriesController < ApplicationController
  def index
  	@breweries = Brewery.all

    collator = ICU::Collation::Collator.new("pl_PL")

    @breweries.sort! { |a, b| collator.compare(a.nazwa, b.nazwa) }

    @breweries = Kaminari.paginate_array(@breweries).page(params[:page]).per(25)
  end

  def polish
    brew = Brewery.all

    collator = ICU::Collation::Collator.new("pl_PL")

    brew.sort! { |a, b| collator.compare(a.nazwa, b.nazwa) }

    brew_temp = Array.new

    brew.each { |brewery| 
     
      if brewery.country == "pl"
        brew_temp.push(brewery)
      end
    }

    @breweries = Kaminari.paginate_array(brew_temp).page(params[:page]).per(25)
  end

  def foreign
    brew = Brewery.all

    collator = ICU::Collation::Collator.new("pl_PL")

    brew.sort! { |a, b| collator.compare(a.nazwa, b.nazwa) }

    brew_temp = Array.new

    brew.each { |brewery| 
     
      unless brewery.country == "pl"
        brew_temp.push(brewery)
      end
    }

    @breweries = Kaminari.paginate_array(brew_temp).page(params[:page]).per(25)
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
    @brewer = Brewery.where("nazwa LIKE ?", "%"+params[:term]+"%")

    resp = Array.new

    @brewer.each { |brewery|
      resp.push ({ "id" => brewery.id, "label" => brewery.nazwa, "value" => brewery.nazwa})
    }

    render json: resp
  end
end
