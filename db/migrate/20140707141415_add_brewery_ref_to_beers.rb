class AddBreweryRefToBeers < ActiveRecord::Migration
  def change
    alter_table :beers do |t|
    	t.references :brewery
    end
  end
end
