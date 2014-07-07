class Brewery < ActiveRecord::Base
  attr_accessor :beer_count
  attr_accessible :nazwa, :beer_count
end
