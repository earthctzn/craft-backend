class Api::V1::ReviewsController < ApplicationController

    def create
        brewery = Brewery.find_or_create_by(name: params[:name])
        review = Review.new(content: params[:content])
        if review.save
            render json: review, include:[:brewery]
        else
            render json: {errors: review.errors.full_messages}
        end
    end

    def show
        review = Review.find_by(id: params[:id])
        render json: review
    end

    def destroy 
        review = Review.find_by(id: params[:id])
        review.destroy
    end
end