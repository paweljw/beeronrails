class Brewery < ActiveRecord::Base
	attr_accessible :nazwa

	def country
		beer = Beer.find(:first, :conditions => [ "brewery_id = ?", self.id ])

		unless beer.nil?
			return beer.country
		else
			return "_"
		end
	end

	def beer_count
		return Beer.find(:all, :conditions => ["brewery_id = ?", self.id]).count
	end

	def permalink
    	return self.nazwa.parameterize
  	end

  	def to_param
    	"#{id}-#{permalink}"
  	end
end
