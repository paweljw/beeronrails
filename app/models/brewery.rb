class Brewery < ActiveRecord::Base
	attr_accessible :nazwa

	def country
		beer = Beer.find(:first, :conditions => [ "brewery_id = ?", self.id ])

		unless beer.nil?
			return beer.kraj
		else
			return "_"
		end
	end

	def beer_count
		return Beer.find(:all, :conditions => ["brewery_id = ?", self.id]).count
	end
end
