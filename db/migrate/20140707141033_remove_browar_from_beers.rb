class RemoveBrowarFromBeers < ActiveRecord::Migration
  def up
    remove_column :beers, :browar
  end

  def down
    add_column :beers, :browar, :string
  end
end
