class Api::V1::UsersController < ApplicationController

    def create
        user = User.new(user_params)
        # byebug
        if user.save
          logg_in(user)
            render json: user, except: [:password_digest], status: 200
        else
            render json: {errors: user.errors.full_messages}
        end
    end
    

    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :uid)
    end
end