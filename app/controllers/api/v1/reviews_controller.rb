class Api::V1::ReviewsController < ApplicationController

    def index
        reviews = Review.all
        render json: reviews, only: [:id, :content, :username, :user_id, :created_at], status: 200
    end

    def create
        brewery = Brewery.find_or_create_by(brewery_params)
        review = Review.new(
            content: review_params[:content], 
            user_id: review_params[:user_id], 
            brewery_id: brewery.id,
            username: review_params[:username]
        )
        if review.save
            render json: review, only: [:id, :content, :user_id, :username, :created_at], status: 200
        else
            render json: {error: "Error Creating Review"}
        end
    end

    def show
        review = Review.find_by(id: params[:id])
        render json: review, only: [:id, :content, :user_id, :username, :created_at],  status: 200
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
                :brewery_id,
                :username
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