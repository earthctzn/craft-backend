class Api::V1::ReviewsController < ApplicationController

    def index
        reviews = Review.all
        render json: reviews, include: [:brewery]
    end

    def create
        brewery = Brewery.find_or_create_by(name: params[:name])
        review = Review.new(content: params[:content])
        if review.save
            render json: review, include:[:brewery], status: 200
        else
            render json: {errors: review.errors.full_messages}
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
end