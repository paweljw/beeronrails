class BeersController < ApplicationController
	def new
		@beer = Beer.new
	end

	def create
  		@beer = Beer.new(params[:beer])
 
		if @beer.save
			redirect_to @beer
		else
			render 'new'
		end
	end

	def show
  		@beer = Beer.find(params[:id])
	end

	def index
		@beers = Beer.all
	end
end
