class SessionsController < ApplicationController


    def fbauth
        user = User.from_facebook(auth)
        if user.save
            session[:user_id] = user.id
            cookies[:logged_in] = true
            render json: user, except: [:password_digest]
        else
            render json: {message: "error on fb login"}
        end
    end

    def create
        user = User.find_by(email: params[:email])
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