require "rails_helper"

RSpec.describe BoredService do
  describe "instance methods", :vcr do
    context "#fetch_api" do
      it "returns json object" do
        response = BoredService.new.fetch_api

        expect(response).to be_a(Hash)
        keys = [:activity, :type, :participants, :price, :link, :key, :accessibility]
        expect(response.keys).to eq(keys)
      end
    end
  end
end
