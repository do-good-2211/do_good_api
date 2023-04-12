class RandomAct
  attr_reader :deed_names, :id

  def initialize(deed_names)
    @deed_names = deed_names
    @id = nil
  end
end
