# frozen_string_literal: true

# app/controllers/api/v1/users/good_deeds_controller.rb
class Api::V1::Users::GoodDeedsController < ApplicationController
  before_action :check_deed_status, only: [:destroy]

  def create
    new_good_deed = GoodDeed.new(name: params[:name], host_id: params[:user_id], date: params[:date], time: params[:time])
    return unless new_good_deed.save!

    new_good_deed.add_participants(params[:attendees], params[:user_id].to_i)
    render json: GoodDeedsCreateSerializer.new(new_good_deed), status: :created
  end

  def destroy
    user_deed = UserGoodDeed.find_by(good_deed_id: params[:id])
    user_deed.destroy
    @deed.destroy
  end

  def check_deed_status
    @deed = GoodDeed.find(params[:id])
    return unless @deed.status == 'Completed'

    render json: ErrorSerializer.new('Completed good deed cannot be deleted').invalid_request, status: :not_found
  end

  def show
    deed = GoodDeed.find(params[:id])
    render json: GoodDeedSerializer.new(deed)
  end

  def update
    @user = User.find(params[:user_id])
    @good_deed = GoodDeed.find(params[:id])
    new_params = good_deed_params
    new_params[:status] = params[:deed_status]

    @good_deed.assign_attributes(new_params)
    if @good_deed.status_changed?
      @good_deed.users.each do |user|
        UserNotifierMailer.send_completed_deed_email(user).deliver_now
      end
    end

    @good_deed.update!(new_params)
    render json: GoodDeedSerializer.new(@good_deed)
  end

  private

  def good_deed_params
    params.permit(:name, :date, :time, :notes, :status, :media_link, :attendees, :host_id)
  end
end
