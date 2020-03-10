class Api::V1::ReviewsController < ApplicationController

    def index
        reviews = Review.all
        render json: reviews, include: [:user]
    end

    def create
        brewery = Brewery.find_or_create_by(brewery_params)
        review = Review.new(
            content: review_params[:content], 
            user_id: review_params[:user_id], 
            brewery_id: brewery.id
        )
        if review.save
            render json: review, include: [:user], status: 200
        else
            render json: {error: "Error Creating Review"}
        end
    end

    def show
        review = Review.find_by(id: params[:id])
        render json: review, status: 200
    end

    def destroy 
        review = Review.find_by(id: params[:id])
        review.destroy
    end

    private
        def review_params
            params.require(:review,).permit(
                :content, 
                :user_id, 
                :brewery_id
            )
        end

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