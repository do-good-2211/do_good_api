require "rails_helper"

RSpec.describe BoredFacade do
  describe "instance methods", :vcr do
    context "#initialize" do
      it "exists and creates an instance of bored service" do
        bored_facade = BoredFacade.new

        expect(bored_facade).to be_a(BoredFacade)
        expect(bored_facade.bored_service).to be_a(BoredService)
      end
    end

    context "#get_3_acts" do
      it "returns an array of 3 random act objects" do
        bored_facade = BoredFacade.new

        expect(bored_facade.get_3_acts).to be_a(RandomAct)
        expect(bored_facade.get_3_acts.deed_names).to be_an(Array)
        expect(bored_facade.get_3_acts.deed_names.count).to eq(3)
        expect(bored_facade.get_3_acts.deed_names.first).to be_a(String)
      end
    end
  end
end
