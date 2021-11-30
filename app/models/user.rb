class User < ApplicationRecord
  has_secure_password

  has_many :movies

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
