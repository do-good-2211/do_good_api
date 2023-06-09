# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  has_many :user_good_deeds
  has_many :good_deeds, through: :user_good_deeds

  validates :name, :role, :email, :uid, presence: true
  validates :email, :uid, uniqueness: true

  enum role: { user: 0, admin: 1 }

  def self.from_omniauth(response)
    find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
      u.name = response[:info][:name] || response[:info][:email]
      u.email = response[:info][:email]
    end
  end
end
