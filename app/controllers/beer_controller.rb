class BeerController < ApplicationController
  before_filter :authenticate, :except => [:index, :denied]

  def index
  end
end
