class Beer < ActiveRecord::Base
  attr_accessor :brewery_name
  attr_accessible :foto, :komentarz, :kraj, :nazwa, :brewery_id, :barcode, :brewery_name

  validates :nazwa, presence: true
  validates :kraj, presence: true
end
