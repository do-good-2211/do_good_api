# frozen_string_literal: true

# app/controllers/api/v1/users/good_deeds_controller.rb
class Api::V1::Users::GoodDeedsController < ApplicationController
  def create
    new_good_deed = GoodDeed.new(name: params[:deed_name], host_id: params[:user_id], date: params[:date], time: params[:time])

    if new_good_deed.save!
      GoodDeed.last.add_participants(params[:attendees], params[:user_id].to_i)
      
      # user = User.find(params[:user_id])
      # render json: UserSerializer.new(user) #, status: 201
      # render json: status: 201
      
      render json: GoodDeedSerializer.new(new_good_deed), status: 201
    else
      render json: { errors: new_item.errors.full_messages.join(', ') }, status: :bad_request
    end
  end
end