class Beer < ActiveRecord::Base
  attr_accessor :icons
  attr_accessible :foto, :komentarz, :kraj, :nazwa, :brewery_id, :barcode, :icons

  validates :nazwa, presence: true
  validates :kraj, presence: true

  attr_accessor :inner_brewery

  def brewery_name
    if self.brewery_id.nil?
      return ""
    end

  	if @inner_brewery
  		return @inner_brewery
  	else 
  		@inner_brewery = Brewery.find(self.brewery_id).nazwa
  		return @inner_brewery
  	end
  end
end
