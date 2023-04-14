# frozen_string_literal: true

# app/models/good_deed.rb
class GoodDeed < ApplicationRecord
  has_many :user_good_deeds, dependent: :destroy
  has_many :users, through: :user_good_deeds

  validates_presence_of :name, :host_id, :date, :time, :status

  enum status: ["In Progress", "Completed"]

  def add_participants(all_invitees, host_id)
    all_participant_ids = all_invitees.map do |invitee|
      invitee["user_id"]
    end
    all_participant_ids << host_id

    ActiveRecord::Base.transaction do
      all_participant_ids.each do |id|
        user = User.find(id)
        UserGoodDeed.create(good_deed_id: self.id, user_id: user.id)
      end
    end
  end
end
