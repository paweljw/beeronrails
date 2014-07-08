class BeerController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  def index
  end
end
