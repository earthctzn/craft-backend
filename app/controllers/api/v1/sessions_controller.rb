class Api::V1::SessionsController < ApplicationController


    def fbauth
        user = User.from_facebook(auth)
        if user.save
            logg_in(user)
            render json: user, only: [:username]
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            logg_in(user)
            render json: user, only: [:username]
        else
            render json: {errors: user.errors.full_messages}
    end

    def logout
        session.clear
    end

    def facebook_redirect
        redirect_to '/auth/facebook'
    end


    private

    def auth
        request.env['omniauth.auth']
    end

    
end