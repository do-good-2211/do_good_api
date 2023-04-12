# frozen_string_literal: true

# app/models/good_deed.rb
class GoodDeed < ApplicationRecord
  has_many :user_good_deeds
  has_many :users, through: :user_good_deeds

  validates_presence_of :name, :host_id, :date, :time, :status

  enum status: ["In Progress", "Completed"]
end
