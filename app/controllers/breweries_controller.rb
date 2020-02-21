class Breweries < ApplicationController

    def index
        breweries = Brewery.all
        render json: breweries status: 200
    end

    def create
        brewery = Brewery.new(brewery_params)
        if brewery.save
            render json: brewery
        else
            render json: {message: "error on create"}
        end
    end

    def show
        brewery = Brewery.find_by(id: params[:id])
    end
    
    private
    
    def brewery_params
        params.require(:brewery).permit(
            :name, 
            :brewery,
            :brewery_type,
            :street,
            :city,
            :state,
            :postal_code,
            :country,
            :longitude,
            :latitude,
            :phone,
            :website_url
        )
    end
end