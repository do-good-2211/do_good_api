# frozen_string_literal: true

# app/poros/random_act.rb
class RandomAct
  attr_reader :deed_names, :id

  def initialize(deed_names)
    @deed_names = deed_names
    @id = nil
  end
end
