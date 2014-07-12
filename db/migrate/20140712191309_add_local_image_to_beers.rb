class AddLocalImageToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :local_image, :string
  end
end
