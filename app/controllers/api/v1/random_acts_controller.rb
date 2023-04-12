# frozen_string_literal: true

# app/controllers/api/v1/random_acts_controller.rb
class Api::V1::RandomActsController < ApplicationController
  def index
    random_acts = BoredFacade.new.three_random_acts
    render json: RandomActsSerializer.new(random_acts)
  end
end
