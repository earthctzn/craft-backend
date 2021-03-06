class Api::V1::BreweriesController < ApplicationController


    def index
        breweries = Brewery.all
        render json: breweries, except: [:updated_at, :created_at], include: [:reviews]
    end

    def create
        brewery = Brewery.new(brewery_params)
        if brewery.save
            render json: brewery, except: [:updated_at, :created_at], include: [:reviews]
        else
            render json: {errors: brewery.errors.full_messages}
        end
    end

    def show
        brewery = Brewery.find_or_create_by(brewery_params)
        if brewery
            render json: brewery, except: [:updated_at, :created_at], include: [:reviews]
        else
            render json: {errors: brewery.errors.full_messages}
        end
    end
    
    private
    
    def brewery_params
        params.require(:brewery).permit(
            :name,
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