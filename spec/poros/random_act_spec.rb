require "rails_helper"

RSpec.describe RandomAct do
  describe "instance methods" do
    context "#initialize" do
      it "exists and has attributes" do
        random_act = RandomAct.new(%w[1 2 3])

        expect(random_act.deed_names).to eq(%w[1 2 3])
        expect(random_act.id).to eq(nil)
      end
    end
  end
end
