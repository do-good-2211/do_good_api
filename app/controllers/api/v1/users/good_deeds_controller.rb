# frozen_string_literal: true

# app/controllers/api/v1/users/good_deeds_controller.rb
class Api::V1::Users::GoodDeedsController < ApplicationController
  before_action :check_deed_status, only: [:destroy]

  def create
    new_good_deed = GoodDeed.new(name: params[:deed_name], host_id: params[:user_id], date: params[:date], time: params[:time])
    return unless new_good_deed.save!

    new_good_deed.add_participants(params[:attendees], params[:user_id].to_i)
    render json: GoodDeedsCreateSerializer.new(new_good_deed), status: 201
  end

  def destroy
      user_deed = UserGoodDeed.find_by(good_deed_id: params[:id])
      user_deed.destroy
      @deed.destroy
  end


  def check_deed_status
    @deed = GoodDeed.find(params[:id])
    if @deed.status == "Completed"
      render json: ErrorSerializer.new("Completed good deed cannot be deleted").invalid_request, status: 404
    end
  end

  def show
    deed = GoodDeed.find(params[:id])
    render json: GoodDeedSerializer.new(deed)
  end
end
