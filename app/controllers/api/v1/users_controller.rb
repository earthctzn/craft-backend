class Api::V1::UsersController < ApplicationController

    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            render json: user, only: [:id, :username], status: 200
        else
            render json: {errors: user.errors.full_messages}
        end
    end
    

    private
    def user_params
        params.require(:user).permit(
            :username, 
            :email, 
            :password, 
            :password_confirmation
        )
    end
end