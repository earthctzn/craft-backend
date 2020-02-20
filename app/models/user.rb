class User < ApplicationRecord

    has_secure_password

    has_many :favorites
    has_many :reviews
    has_many :breweries, through: :favorites
    has_many :breweries, through: :reviews

end