class Brewery < ActiveRecord::Base
  attr_accessor :beer_count, :country
  attr_accessible :nazwa, :beer_count, :country
end
