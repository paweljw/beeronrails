require 'test_helper'

class BreweryTest < ActiveSupport::TestCase
  test "should not save brewery with no name" do
  	brewery = Brewery.new
  	refute brewery.save
  end

  test "should save brewery with weird characters" do
  	brewery = Brewery.new
  	brewery.nazwa = "&"
  	assert brewery.save
  end

  test "should save brewery with '" do
  	brewery = Brewery.new
  	brewery.nazwa = "Young's and Well's"
  	assert brewery.save
  end

end
