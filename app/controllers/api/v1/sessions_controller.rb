class Api::V1::SessionsController < ApplicationController

    def create
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            render json: user, only: [:id, :username], include: [:reviews], status: :ok
        else
            render json: {errors: user.errors.full_messages }
        end
    end

    def set_token
        auth_token = form_authenticity_token
        render json: {csrf_auth_token: auth_token}
    end

    def get_user
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, only: [:id, :username], include: [:reviews], status: :ok
        end
    end

    def destroy
        session.clear
    end


    
end


    # Facebook login stuff not required but nice add-on for later.

    # def fbauth
    #     user = User.from_facebook(auth)
    #     if user
    #         render json: user, only: [:id, :username], include: [:reviews], status: :ok
    #     else
    #         render json: {errors: user.errors.full_messages}
    #     end
    # end


    # def auth
    #     request.env['omniauth.auth']
    # end

