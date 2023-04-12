# frozen_string_literal: true

# app/models/user_good_deed.rb
class UserGoodDeed < ApplicationRecord
  belongs_to :user
  belongs_to :good_deed
end
