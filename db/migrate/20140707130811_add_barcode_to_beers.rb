class AddBarcodeToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :barcode, :string
  end
end
