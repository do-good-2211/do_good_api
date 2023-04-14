# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  has_many :user_good_deeds
  has_many :good_deeds, through: :user_good_deeds

  validates_presence_of :name, :role, :email, :password, :uid
  validates_uniqueness_of :email, :uid
  validates :password, confirmation: true

  has_secure_password

  enum role: %i[user admin]

  def self.from_omniauth(response)
    find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
      u.name = response[:info][:name]  
      u.email = response[:info][:email]  
      u.password = SecureRandom.hex(15)  
    end  
  end
end


