class SessionsController < ApplicationController

    def facebook_callback(auth)
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
          @upass = Sysrandom.hex(32)
          u.password = @upass
          u.password_confirmation = @upass
        end
        session[:user_id] = user.id
        cookies[:logged_in] = true
        redirect_to 'http://localhost:5000'
    end



    private

    def auth
        request.env['omniauth.auth']
    end
end