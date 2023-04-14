# frozen_string_literal: true

# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  def render_invalid_response(exception)
    render json: ErrorSerializer.new(exception.message).invalid_request, status: :not_found
  end
end
