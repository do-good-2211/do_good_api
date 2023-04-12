class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_response

  def render_invalid_response(exception)
    render json: ErrorSerializer.new(exception.message).invalid_request, status: 404
  end
end
