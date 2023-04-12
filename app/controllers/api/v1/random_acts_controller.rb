class Api::V1::RandomActsController < ApplicationController 
  def index 
    random_acts = BoredFacade.new.get_3_acts
    render json: RandomActsSerializer.new(random_acts)
  end
end