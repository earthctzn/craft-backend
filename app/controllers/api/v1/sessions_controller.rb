class Api::V1::SessionsController < ApplicationController


    def fbauth
        user = User.from_facebook(auth)
        if user.save
            session[:user_id] = user.id
            cookies["logged_in"] = true
            render json: user, include: [:reviews], status: :ok
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def create
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            cookies["logged_in"] = true
            render json: user, except: [:password_digest, :uuid, :created_at, :updated_at], include: [:reviews], status: :ok
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def set_token
        render json: {csrf_auth_token: form_authenticity_token}
    end

    def current_user
        user = User.find_by(id: session[:user_id])
    end

    def destroy
        reset_session
        cookies["logged_in"] = false
    end

    def facebook_redirect
        redirect_to '/auth/facebook'
    end


    private

    def auth
        request.env['omniauth.auth']
    end




    
end