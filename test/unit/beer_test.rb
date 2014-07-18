require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  test "should not save beer without name" do
  	beer = Beer.new
  	refute beer.save
  end

  test "should not save beer with no brewery" do
  	beer = Beer.new
  	beer.nazwa = "Test"

  	refute beer.save
  end

  test "should save beer with ' in name" do
  	beer = Beer.new
  	beer.nazwa = "Young's Bitter UTF-8 Ale"

  	brewery = Brewery.new
  	brewery.nazwa = "Test"

  	beer.brewery_id = brewery.id

  	beer.kraj = "_"

  	assert beer.save
  end
end
