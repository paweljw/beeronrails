class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :nazwa
      t.string :browar
      t.string :foto
      t.string :kraj
      t.text :komentarz

      t.timestamps
    end
  end
end
