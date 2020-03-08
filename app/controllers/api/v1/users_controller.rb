class Api::V1::UsersController < ApplicationController

    def create
        user = User.new(user_params)
        if user.save
            #binding.pry
            session[:user_id] = user.id
            render json: user, only: [:id, :username], include: [:reviews], status: :ok
        else
            render json: {errors: user.errors.full_messages}
        end
    end
    

    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :uid)
    end
end