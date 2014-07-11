class AddBreweryRefToBeers < ActiveRecord::Migration
  def change
    change_table :beers do |t|
    	t.references :brewery
    end
  end
end
