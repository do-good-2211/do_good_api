require "rails_helper"

RSpec.describe "Good Deeds request" do
  describe "#index" do
    it "returns a an array of all good deeds with completed status" do
      @good_deed1 = create(:good_deed)
      @good_deed2 = create(:good_deed, status: 1)
      @good_deed3 = create(:good_deed, status: 1)
      keys = [:id, :type, :attributes]

      get "/api/v1/good_deeds"
      deeds = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(deeds).to be_a(Hash)
      expect(deeds[:data]).to be_a(Array)
      expect(deeds[:data].count).to eq(2)
      deeds[:data].each do |deed|
        expect(deed.keys).to eq(keys)
        expect(deed[:attributes].keys).to eq([:name, :media_link])
      end
    end
  end
end
