require 'rails_helper'

RSpec.describe "Good Deeds Controller" do
  describe "#create" do
    before(:each) do
      @users = create_list(:user, 3)
    end

    let(:user) { @users[0] }
    let(:invitee1) { @users[1] }
    let(:invitee2) { @users[2] }

    let(:good_deed_params) do
      {
        name:,
        date:,
        time:,
        attendees: invitees
      }
    end

    describe "when sucessful" do
      let(:name) { "Wash neighbor's car." }
      let(:date) { "01-01-2023" }
      let(:time) { "17:00" }

      describe "when 1+ invitees" do
        let(:invitees) { [invitee1.id, invitee2.id] }

        it "creates a new Good Deed record" do
          headers = { "CONTENT_TYPE" => "application/json" }
          post "/api/v1/users/#{user.id}/good_deeds", headers:, params: JSON.generate(good_deed_params)

          expect(response).to be_successful
          parsed_data = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_data).to be_a(Hash)
          expect(parsed_data[:data]).to be_a(Hash)
          expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
          expect(parsed_data[:data][:attributes]).to be_a(Hash)
          expect(parsed_data[:data][:attributes].keys).to eq([:name, :media_link, :notes, :date, :time, :status, :host_id])
        end
      end

      describe "when 0 invitees" do
        let(:invitees) { [] }

        it "creates a new Good Deed record when there are 0 invitees" do
          headers = { "CONTENT_TYPE" => "application/json" }
          post "/api/v1/users/#{user.id}/good_deeds", headers:, params: JSON.generate(good_deed_params)

          expect(response).to be_successful
          parsed_data = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_data).to be_a(Hash)
          expect(parsed_data[:data]).to be_a(Hash)
          expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
          expect(parsed_data[:data][:attributes]).to be_a(Hash)
          expect(parsed_data[:data][:attributes].keys).to eq([:name, :media_link, :notes, :date, :time, :status, :host_id])
        end
      end
    end

    describe "when NOT sucessful" do
      describe "when attributes are missing" do
        let(:name) { "" }
        let(:date) { "" }
        let(:time) { "" }
        let(:invitees) { [invitee1.id, invitee2.id] }

        it "returns 404" do
          headers = { "CONTENT_TYPE" => "application/json" }
          post "/api/v1/users/#{user.id}/good_deeds", headers:, params: JSON.generate(good_deed_params)

          parsed_data = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(404)
          expect(parsed_data[:errors].first[:detail].first).to eq("Validation failed: Name can't be blank, Date can't be blank, Time can't be blank")
        end
      end

      describe "when attributes are nil/invalid" do
        let(:name) { nil }
        let(:date) { nil }
        let(:time) { nil }
        let(:invitees) { nil }

        it "returns 404" do
          headers = { "CONTENT_TYPE" => "application/json" }
          post "/api/v1/users/#{user.id}/good_deeds", headers:, params: JSON.generate(good_deed_params)

          parsed_data = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(404)
          expect(parsed_data[:errors].first[:detail].first).to eq("Validation failed: Name can't be blank, Date can't be blank, Time can't be blank")
        end
      end

      describe "EDGE CASE: when invited user_ids are invalid" do
        let(:name) { "Wash neighbor's car." }
        let(:date) { "01-01-2023" }
        let(:time) { "17:00" }
        let(:invitees) { [invitee2.id, 0 ] }

        it "returns 404" do
          headers = { "CONTENT_TYPE" => "application/json" }
          post "/api/v1/users/#{user.id}/good_deeds", headers:, params: JSON.generate(good_deed_params)

          parsed_data = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(404)
          expect(parsed_data[:errors].first[:detail].first).to eq("Couldn't find User with 'id'=0")
        end
      end
    end
  end

  describe "#destroy" do
    it 'deletes the good deed' do
      create_list(:user, 2)
      user1 = User.first
      user2 = User.last

      deed1 = create(:good_deed, host_id: user2.id)
      deed2 = create(:good_deed, host_id: user2.id)

      create(:user_good_deed, user_id: user2.id, good_deed_id: deed1.id)
      create(:user_good_deed, user_id: user1.id, good_deed_id: deed1.id)
      create(:user_good_deed, user_id: user2.id, good_deed_id: deed2.id)

      expect(user2.good_deeds.count).to eq(2)
      expect(user1.good_deeds.count).to eq(1)

      delete "/api/v1/users/#{user2.id}/good_deeds/#{deed1.id}"

      expect(response).to be_successful
      expect(user2.good_deeds.count).to eq(1)
      expect(user1.good_deeds.count).to eq(0)
    end

    it "couldn't delete if user or good deed does not exist" do
      user = create(:user)
      deed1 = create(:good_deed, host_id: user.id, status: 1)
      create(:user_good_deed, user_id: user.id, good_deed_id: deed1.id)

      expect(user.good_deeds.count).to eq(1)

      delete "/api/v1/users/#{user.id}/good_deeds/#{deed1.id}"

      parse = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(parse).to be_a(Hash)
      expect(parse.keys).to eq([:errors])
      expect(parse[:errors]).to be_an(Array)
      expect(parse[:errors][0].keys).to eq([:status, :title, :detail])
      expect(parse[:errors][0][:detail]).to eq(["Completed good deed cannot be deleted"])
    end
  end

  describe "#edit" do
    it "update an existing good deed" do
      user = create(:user)
      good_deed1 = create(:good_deed)
      UserGoodDeed.create(user_id: user.id, good_deed_id: good_deed1.id)

      previous_status = good_deed1.status
      previous_name = good_deed1.name

      good_deed_params = {
        name: "Mow Lawn",
        date: "02-02-2024",
        time: "16:00",
        notes: "Stuff and things",
        status: "Completed",
        media_links: "picture.jpg",
        host_id: user.id,
        attendees: []
      }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/users/#{user.id}/good_deeds/#{good_deed1.id}", headers:, params: JSON.generate(good_deed_params)

      parse = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(parse).to be_a(Hash)
      expect(parse[:attributes][:status]).to_not eq(previous_status)
      expect(parse[:attributes][:status]).to eq("Completed")
      expect(parse[:attributes][:name]).to_not eq(previous_name)
      expect(parse[:attributes][:name]).to eq("Mow Lawn")
    end

    it "can't update when user id invalid" do
      user = create(:user)
      good_deed1 = create(:good_deed)
      UserGoodDeed.create(user_id: user.id, good_deed_id: good_deed1.id)

      good_deed_params = {
        name: "Mow Lawn",
        date: "02-02-2024",
        time: "16:00",
        notes: "Stuff and things",
        status: "Completed",
        media_links: "picture.jpg",
        host_id: user.id,
        attendees: []
      }

      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/users/abc/good_deeds/#{good_deed1.id}", headers:, params: JSON.generate(good_deed_params)
      parse = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(parse[:errors][0][:detail].first).to eq("Couldn't find User with 'id'=abc")
    end

    it "can't update when good deed id invalid" do
      user = create(:user)
      good_deed1 = create(:good_deed)
      UserGoodDeed.create(user_id: user.id, good_deed_id: good_deed1.id)

      good_deed_params = {
        name: "Mow Lawn",
        date: "02-02-2024",
        time: "16:00",
        notes: "Stuff and things",
        status: "Completed",
        media_links: "picture.jpg",
        host_id: user.id,
        attendees: []
      }

      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/users/#{user.id}/good_deeds/zxvsd46546", headers:, params: JSON.generate(good_deed_params)
      parse = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(parse[:errors][0][:detail].first).to eq("Couldn't find GoodDeed with 'id'=zxvsd46546")
    end
  end
end
