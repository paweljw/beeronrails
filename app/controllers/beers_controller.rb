require "ffi-icu"

class BeersController < ApplicationController
	# before_filter :authenticate, :except => [:index, :show]

	def new
		@beer = Beer.new
	end

	def create
  		@beer = Beer.new(beer_params)
 
		if @beer.save
			redirect_to @beer
		else
			render 'new'
		end
	end

	def show
  		@beer = Beer.find(params[:id])

  		@brewery = Brewery.find(@beer.brewery_id)
  		@beer.brewery_name = @brewery.nazwa
	end

	def index
		@beers = Beer.all

		@beers.each { |beer| 

		  		brewery = Brewery.find(beer.brewery_id)
  				beer.brewery_name = brewery.nazwa
  			}

		collator = ICU::Collation::Collator.new("pl_PL")

  		@beers = @beers.sort! { |a, b| collator.compare(a.brewery_name, b.brewery_name)}
	end

	def edit
		@beer = Beer.find(params[:id])

		@brewery = Brewery.find(@beer.brewery_id)
		@beer.brewery_name = @brewery.nazwa
	end

	def update
		@beer = Beer.find(params[:id])

		if @beer.update_attributes(beer_params)
			redirect_to @beer
		else
			render 'edit'
		end
	end

	private
  		def beer_params
  			# get brewery name
  			brewery_name = params[:beer][:brewery_name].strip

  			@brewery = Brewery.where("nazwa = '" + brewery_name + "'").first

  			if @brewery
  				params[:beer][:brewery_id] = @brewery.id
  			else
  				@brewery = Brewery.new()
  				@brewery.nazwa = brewery_name
  				@brewery.save
  				params[:beer][:brewery_id] = @brewery.id
  			end

    		params.require(:beer).permit(:nazwa, :komentarz, :barcode, :brewery_id, :kraj, :foto)
  		end
end
