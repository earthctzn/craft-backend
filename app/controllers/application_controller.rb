class ApplicationController < ActionController::API
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    before_action :verify_token
    #protect_from_forgery with: :exception

    helper_method :logged_in?

    def logged_in?
        !!session[:user_id]
    end



    private 

    def verify_token
        valid_authenticity_token?(session, request.headers["X-CSRF-Token"]) if required_csrf_methods.include?(request.method) 
    end
    
    def required_csrf_methods
        ["POST", "PATCH", "DELETE"]
    end

end
