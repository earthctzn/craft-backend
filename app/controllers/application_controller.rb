class ApplicationController < ActionController::API
    before_action :set_csrf_cookie
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    # rescue_from AppError::AuthenticationError, with: :unauthorized

    protect_from_forgery with: :exception

    def current_user
        User.find_by(id: session[:user_id])
    end

    def logged_in?
        !!current_user
    end
    
    # def authenticate
    #     raise AppError::AuthenticationError if !logged_in?
    # end

    def unauthorized
        render json: {error: "You are not Authorized"}, status: 401
    end

    private
        def set_csrf_cookie
            cookies["CSRF_TOKEN"] = form_authenticity_token
        end

end
