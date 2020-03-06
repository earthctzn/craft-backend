class Api::V1::UsersController < ApplicationController

    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            cookies["logged_in"] = true
          render json: user, except: [:password_digest, :uid, :created_at, :updated_at], include: [:reviews], status: :ok
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def current_user
        user = User.find_by(id: session[:user_id])
        render json: user, except: [:password_digest, :uid, :created_at, :updated_at], include: [:reviews], status: :ok  
    end
    

    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :uid)
    end
end