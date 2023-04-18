# frozen_string_literal: true

# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  def index
    render json: UsersSerializer.new(User.all)
  end

  def show
    render json: UsersSerializer.new(User.find(params[:id]))
  end

  def create
    user = User.from_omniauth(params[:query])
    if user.valid?
      render json: UsersSerializer.new(user)
    else
      render json: ErrorSerializer.new(user.errors.full_messages.join)
    end
  end
end
