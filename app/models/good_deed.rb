# frozen_string_literal: true

# app/models/good_deed.rb
class GoodDeed < ApplicationRecord
  has_many :user_good_deeds, dependent: :destroy
  has_many :users, through: :user_good_deeds

  validates :name, :host_id, :date, :time, :status, presence: true

  enum status: { "In Progress" => 0, "Completed" => 1 }

  def add_participants(all_invitees, host_id)
    all_invitees = [] if all_invitees == nil
    all_invitees << host_id

    ActiveRecord::Base.transaction do
      all_invitees.each do |id|
        user = User.find(id)
        UserGoodDeed.create(good_deed_id: self.id, user_id: user.id)
      end
    end
  end

  def self.completed_photo_deeds
    GoodDeed.where("status = 1").where("media_link IS NOT NULL")
  end

  def attendees 
    users.where.not(id: self.host_id)
  end

  def host_name
    User.find(self.host_id).name
  end
end
