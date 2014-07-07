class BeersController < ApplicationController
	def new
	end

	def create
  		@beer = Beer.new(params[:beer])
 
		@beer.save
		redirect_to @beer
	end

	def show
  		@beer = Beer.find(params[:id])
	end

	def index
		@beers = Beer.all
	end
end
