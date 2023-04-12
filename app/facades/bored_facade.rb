class BoredFacade
  attr_reader :bored_service

  def initialize
    @bored_service = BoredService.new
  end

  def get_3_acts
    acts_collection = []
    3.times do
      acts_collection << bored_service.fetch_api
    end

    three_acts = acts_collection.map do |act_info_hash|
      act_info_hash[:activity]
    end
    RandomAct.new(three_acts)
  end
end
