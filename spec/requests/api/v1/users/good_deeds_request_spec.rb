require 'rails_helper'

RSpec.describe "Good Deeds Controller" do
  describe "#create" do
    before(:each) do
      @users = create_list(:user, 3)
    end

      let(:user) { @users[0] }
      let(:invitee1) { @users[1] }
      let(:invitee2) { @users[2] }

      let(:good_deed_params) {{
        deed_name: deed_name, 
        date: date, 
        time: time, 
        attendees: attendees
      }}

    describe "when sucessful" do 
      let(:deed_name) { "Wash neighbor's car." }
      let(:date) { "01-01-2023" }
      let(:time) { "17:00" }
      let(:attendees) { [{ "user_id": invitee1.id }, { "user_id": invitee2.id }] }

      it "creates a new Good Deed record when there are 1+ invitees" do # OR it only returns status 202?
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/users/#{user.id}/good_deeds", headers: headers, params: JSON.generate(good_deed_params)

        expect(response).to be_successful
        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
        expect(parsed_data[:data]).to be_a(Hash)
        expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed_data[:data][:attributes]).to be_a(Hash)
        expect(parsed_data[:data][:attributes].keys).to eq([:name, :media_link, :notes, :date, :time, :status, :host_id])
      end

      it "creates a new Good Deed record when there are 0 invitees" do
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/users/#{@users[0].id}/good_deeds", headers: headers, params: JSON.generate(@good_deed_params)

        expect(response).to be_successful
        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
        expect(parsed_data[:data]).to be_a(Hash)
        expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed_data[:data][:attributes]).to be_a(Hash)
        expect(parsed_data[:data][:attributes].keys).to eq([:name, :media_link, :notes, :date, :time, :status, :host_id])
      end
    end
      
    describe "when NOT sucessful" do 
      it "returns 404 when ??" do
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/users/#{@users[0].id}/good_deeds", headers: headers, params: JSON.generate(@good_deed_params)

        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)
        expect(parsed_data[:message]).to eq("Couldn't find Item with 'id'=0")

      end
    end
  end
end