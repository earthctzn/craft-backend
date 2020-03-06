class User < ApplicationRecord

    has_secure_password

    has_many :favorites
    has_many :reviews
    has_many :breweries, through: :favorites
    has_many :breweries, through: :reviews

    validates :username, presence: true
    validates :email, uniqueness: true
    validates :email, presence: true
    validates :password, presence: true
    validates :password_confirmation, presence: true, on: :create

    # Facebook stuff for later. 

    # def self.from_facebook(auth)
    #   byebug
    #     @user = User.find_or_create_by(uid: auth['uid']) do |u|
    #       u.username = auth['info']['name']
    #       u.email = auth['info']['email']
    #       @upass = Sysrandom.hex(32)
    #       u.password = @upass
    #       u.password_confirmation = @upass
    #     end
    # end
  
end