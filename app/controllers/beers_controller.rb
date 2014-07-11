require "ffi-icu"

class BeersController < ApplicationController
	before_filter :authenticate, :except => [:index, :show, :polish, :foreign, :search]

	def new
		@beer = Beer.new
	end

	def create
  		@beer = Beer.new(beer_params)
 
		if @beer.save
			@new_beer = @beer
      @beer = Beer.new
      render 'new'
		else
			render 'new'
		end
	end

	def show
  		@beer = beer_name_add_icons(Beer.find(params[:id]))
	end

	def index
    @all_beers_count = all_beers_count
    @polish_beers_count = polish_beers_count
    @foreign_beers_count = foreign_beers_count

    unless params[:shown]
		  @beers = Beer.all
    else
      if params[:shown] == "bottles"
        @beers = Beer.where("komentarz LIKE ? OR komentarz LIKE ?", "%#butelka%", "%#bottle%")
      elsif
        @beers = Beer.where("komentarz NOT LIKE ? AND komentarz NOT LIKE ?", "%#butelka%", "%#bottle%")
      else
        @beers = Beer.all
      end
    end

		collator = ICU::Collation::Collator.new("pl_PL")

		@beers = @beers.sort! do |a, b| 
			comp = collator.compare(a.brewery_name, b.brewery_name)
			comp.zero? ? collator.compare(a.nazwa, b.nazwa) : comp
		end

    @beers.each do |beer|
      beer = beer_name_add_icons(beer)
    end

		@beers = Kaminari.paginate_array(@beers).page(params[:page]).per(25)
	end

  def search
    unless params[:term].nil?
      @beers = Beer.where("nazwa LIKE ? OR barcode LIKE ? OR komentarz LIKE ?", "%"+params[:term]+"%", "%"+params[:term]+"%",  "%"+params[:term]+"%")

      collator = ICU::Collation::Collator.new("pl_PL")

      @beers = @beers.sort! do |a, b| 
        comp = collator.compare(a.brewery_name, b.brewery_name)
        comp.zero? ? collator.compare(a.nazwa, b.nazwa) : comp
      end

      @beers.each do |beer|
        beer = beer_name_add_icons(beer)
      end

      @beers = Kaminari.paginate_array(@beers).page(params[:page]).per(25)
    end
  end

	def edit
		@beer = Beer.find(params[:id])
	end

	def update
		@beer = Beer.find(params[:id])

		if @beer.update_attributes(beer_params)
			redirect_to @beer
		else
			render 'edit'
		end
	end

	def destroy
  		@beer = Beer.find(params[:id])
  		@beer.destroy
 
  		redirect_to beers_path
	end

	def polish
    @all_beers_count = all_beers_count
    @polish_beers_count = polish_beers_count
    @foreign_beers_count = foreign_beers_count

		unless params[:shown]
      @beers = Beer.where(kraj: 'pl')
    else
      if params[:shown] == "bottles"
        @beers = Beer.where("(komentarz LIKE ? OR komentarz LIKE ?) AND kraj LIKE ?", "%#butelka%", "%#bottle%", "pl")
      elsif
        @beers = Beer.where("komentarz NOT LIKE ? AND komentarz NOT LIKE ? AND kraj LIKE ?", "%#butelka%", "%#bottle%", "pl")
      else
        @beers = Beer.all
      end
    end

    collator = ICU::Collation::Collator.new("pl_PL")

    @beers = @beers.sort! do |a, b| 
      comp = collator.compare(a.brewery_name, b.brewery_name)
      comp.zero? ? collator.compare(a.nazwa, b.nazwa) : comp
    end

    @beers.each do |beer|
      beer = beer_name_add_icons(beer)
    end

    @beers = Kaminari.paginate_array(@beers).page(params[:page]).per(25)
 	end

	def foreign
    @all_beers_count = all_beers_count
    @polish_beers_count = polish_beers_count
    @foreign_beers_count = foreign_beers_count

  	unless params[:shown]
      @beers = Beer.where("kraj != ?", "pl")
    else
      if params[:shown] == "bottles"
        @beers = Beer.where("(komentarz LIKE ? OR komentarz LIKE ?) AND kraj NOT LIKE ?", "%#butelka%", "%#bottle%", "pl")
      elsif
        @beers = Beer.where("komentarz NOT LIKE ? AND komentarz NOT LIKE ? AND kraj NOT LIKE ?", "%#butelka%", "%#bottle%", "pl")
      else
        @beers = Beer.all
      end
    end

    collator = ICU::Collation::Collator.new("pl_PL")

    @beers = @beers.sort! do |a, b| 
      comp = collator.compare(a.brewery_name, b.brewery_name)
      comp.zero? ? collator.compare(a.nazwa, b.nazwa) : comp
    end

    @beers.each do |beer|
      beer = beer_name_add_icons(beer)
    end

    @beers = Kaminari.paginate_array(@beers).page(params[:page]).per(25)
	end

	private
  		def beer_params
  			# get brewery name
  			brewery_name = params[:beer][:brewery_name].strip

        @new_brewery = ""

  			@brewery = Brewery.where("nazwa = '" + brewery_name + "'").first

  			if @brewery
  				params[:beer][:brewery_id] = @brewery.id
  			else
  				@brewery = Brewery.new()
  				@brewery.nazwa = brewery_name
  				@brewery.save
          @new_brewery = brewery_name
  				params[:beer][:brewery_id] = @brewery.id
  			end

    		params.require(:beer).permit(:nazwa, :komentarz, :barcode, :brewery_id, :kraj, :foto)
  		end

      def beer_name_add_icons(beer)
        beer.icons = ""
        unless beer.komentarz.empty?
          escaped_comment = beer.komentarz.gsub("'", %q(\\\'))
          beer.icons += "<img src='/assets/icons/comment.png' title='Comment: #{escaped_comment}' />"
        end

        if beer.komentarz.include? "#butelka" or beer.komentarz.include? "#bottle"
          beer.icons += " <img src='/assets/icons/bottle.png' title='This beer is stored as a physical bottle' />"
        end

        if beer.komentarz.include? "#edycjalimitowana" or beer.komentarz.include? "#limited"
          beer.icons += " <img src='/assets/icons/award_star_gold_2.png' title='This beer is a limited edition or an otherwise seasonal product' />"
        end
        #drink.png?
        #award_star_gold_@
        return beer
      end

      def all_beers_count
        return Beer.all.count
      end

      def polish_beers_count
        return Beer.where(kraj: 'pl').count
      end

      def foreign_beers_count
        return Beer.where("kraj != ?", "pl").count
      end
end
