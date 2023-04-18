require "rails_helper"

RSpec.describe "User good deed request", type: :request do
  describe "#show" do
    it "retuns a single user good deed" do
      user = create(:user)
      host = create(:user)
      good_deed1 = create(:good_deed, host_id: host.id)
      UserGoodDeed.create(user_id: user.id, good_deed_id: good_deed1.id)
      keys = [:id, :type, :attributes]
      attribute_keys = [:name, :date, :time, :status, :notes, :media_link, :host_name, :attendees]

      get "/api/v1/users/#{user.id}/good_deeds/#{good_deed1.id}"
      deed = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(deed).to be_a(Hash)
      expect(deed[:data][:id]).to eq(good_deed1.id.to_s)
      expect(deed[:data].keys).to eq(keys)
      expect(deed[:data][:attributes].keys).to eq(attribute_keys)
    end

    it "has a list of attendees" do 
      host = create(:user)
      good_deed = create(:good_deed, host_id: host.id)
      attendee1 = create(:user)
      attendee2 = create(:user)
      udg1 = create(:user_good_deed, user_id: attendee1.id, good_deed_id: good_deed.id)
      udg2 = create(:user_good_deed, user_id: attendee2.id, good_deed_id: good_deed.id)
      udg3 = create(:user_good_deed, user_id: host.id, good_deed_id: good_deed.id)
      keys = [:id, :type, :attributes]
      attribute_keys = [:name, :date, :time, :status, :notes, :media_link, :host_name, :attendees]

      get "/api/v1/users/#{host.id}/good_deeds/#{good_deed.id}"
      deed = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(deed).to be_a(Hash)
      expect(deed[:data][:id]).to eq(good_deed.id.to_s)
      expect(deed[:data].keys).to eq(keys)
      expect(deed[:data][:attributes].keys).to eq(attribute_keys)
      expect(deed[:data][:attributes][:attendees]).to be_an(Array)
      expect(deed[:data][:attributes][:attendees].count).to eq(2)
      expect(deed[:data][:attributes][:attendees].first).to be_a(Hash)
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
