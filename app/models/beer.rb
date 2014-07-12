class Beer < ActiveRecord::Base
  attr_accessor :icons
  attr_accessible :foto, :komentarz, :kraj, :nazwa, :brewery_id, :barcode, :icons, :local_image

  mount_uploader :local_image, LocalImageUploader

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

  def country
    if self.kraj.nil?
      return "_"
    end

    unless self.kraj == "_"
      return self.kraj
    else
      country = EanCountry.infer(self.barcode)
      unless country.nil?
        return country.downcase
      else
        return "_"
      end
    end
  end

  def permalink
    return self.nazwa.parameterize
  end

  def to_param
    "#{id}-#{permalink}"
  end
end
