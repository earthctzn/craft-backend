class Api::V1::SessionsController < ApplicationController


    def fbauth
        user = User.from_facebook(auth)
        if user.save
            logg_in(user)
            render json: user, status: :ok
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def create
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            logg_in(user)
            render json: user
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    # def set_cookie
    #     set_csrf_cookie
    # end

    def destroy
        session.clear
        render json: {
            notice: "You are logged out!"
        }, status: :ok
    end

    def facebook_redirect
        redirect_to '/auth/facebook'
    end


    private

    def auth
        request.env['omniauth.auth']
    end


    # def set_csrf_cookie
    #     cookies["CSRF_TOKEN"] = form_authenticity_token
    # end

    
end