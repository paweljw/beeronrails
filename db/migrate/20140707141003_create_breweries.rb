class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.string :nazwa

      t.timestamps
    end
  end
end