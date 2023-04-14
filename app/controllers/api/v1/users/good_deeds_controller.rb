# frozen_string_literal: true

# app/controllers/api/v1/users/good_deeds_controller.rb
class Api::V1::Users::GoodDeedsController < ApplicationController
  def create
    new_good_deed = GoodDeed.new(name: params[:deed_name], host_id: params[:user_id], date: params[:date], time: params[:time])
    return unless new_good_deed.save!
    new_good_deed.add_participants(params[:attendees], params[:user_id].to_i)
    render json: GoodDeedsSerializer.new(new_good_deed), status: 201
  end

  def destroy
    good_deed = UserGoodDeed.find_by(user_id: params[:user_id], good_deed_id: params[:id])
    good_deed.destroy
  end
end
