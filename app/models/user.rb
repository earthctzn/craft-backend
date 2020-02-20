class User < ApplicationRecord

    has_secure_password

    has_many :favorites
    has_many :reviews
    has_many :breweries, through: :favorites
    has_many :breweries, through: :reviews

    validates :name, presence: true
    validates :email, uniqueness: true
    validates :email, presence: true
    validates :password, presence: true
    validates :password_confirmation, presence: true, on: :create
  
end