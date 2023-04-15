require "rails_helper"

RSpec.describe "User good deed request" do
  describe "#show" do
    it "retuns a single user good deed" do
      user = create(:user)
      good_deed1 = create(:good_deed)
      UserGoodDeed.create(user_id: user.id, good_deed_id: good_deed1.id)
      keys = [:id, :type, :attributes]
      attribute_keys = [:name, :date, :time, :status, :notes, :media_link]

      get "/api/v1/users/#{user.id}/good_deeds/#{good_deed1.id}"
      deed = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(deed).to be_a(Hash)
      expect(deed[:data][:id]).to eq(good_deed1.id.to_s)
      expect(deed[:data].keys).to eq(keys)
      expect(deed[:data][:attributes].keys).to eq(attribute_keys)
    end

    it "retuns a error if the user or good deed is not found" do
      get "/api/v1/users/1/good_deeds/2"
      deed = JSON.parse(response.body, symbolize_names: true)
      keys = [:status, :title, :detail]
      expect(response).to_not be_successful
      expect(deed).to be_a(Hash)
      expect(deed[:errors].first.keys).to eq(keys)
      expect(deed[:errors].first[:title]).to eq("Invalid Request")
      expect(deed[:errors].first[:detail]).to be_a(Array)
    end
  end
end
