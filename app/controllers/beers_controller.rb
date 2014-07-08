require "ffi-icu"

class BeersController < ApplicationController
	before_filter :authenticate, :except => [:index, :show]

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

		page = params[:page].nil? ? 0 : params[:page].to_i-1

		@beers.each { |beer| 

		  		brewery = Brewery.find(beer.brewery_id)
  				beer.brewery_name = brewery.nazwa
  			}

		collator = ICU::Collation::Collator.new("pl_PL")

  		@beers = @beers.sort! do |a, b| 
  			comp = collator.compare(a.brewery_name, b.brewery_name)
  			comp.zero? ? collator.compare(a.nazwa, b.nazwa) : comp
  		end

  		@beers = @beers[page*25..(page+1)*25-1]

  		@brewskies = Beer.page(params[:page])
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

	def destroy
  		@beer = Beer.find(params[:id])
  		@beer.destroy
 
  		redirect_to beers_path
	end

	def polish
		@beers = Beer.where(kraj: 'pl')

		page = params[:page].nil? ? 0 : params[:page].to_i-1

		@beers.each { |beer| 

		  		brewery = Brewery.find(beer.brewery_id)
  				beer.brewery_name = brewery.nazwa
  			}

		collator = ICU::Collation::Collator.new("pl_PL")

  		@beers = @beers.sort! do |a, b| 
  			comp = collator.compare(a.brewery_name, b.brewery_name)
  			comp.zero? ? collator.compare(a.nazwa, b.nazwa) : comp
  		end

  		@beers = @beers[page*25..(page+1)*25-1]

  		@brewskies = Beer.where(kraj: 'pl').page(params[:page])
  	end

  	def foreign
		@beers = Beer.where('kraj != ?', 'pl')

		page = params[:page].nil? ? 0 : params[:page].to_i-1

		@beers.each { |beer| 

		  		brewery = Brewery.find(beer.brewery_id)
  				beer.brewery_name = brewery.nazwa
  			}

		collator = ICU::Collation::Collator.new("pl_PL")

  		@beers = @beers.sort! do |a, b| 
  			comp = collator.compare(a.brewery_name, b.brewery_name)
  			comp.zero? ? collator.compare(a.nazwa, b.nazwa) : comp
  		end

  		@beers = @beers[page*25..(page+1)*25-1]

  		@brewskies = Beer.where('kraj != ?', 'pl').page(params[:page])
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
