class Api::V1::GoodDeedsController < ApplicationController
  def index
    render json: GoodDeedsSerializer.new(GoodDeed.completed_photo_deeds)
  end
end
