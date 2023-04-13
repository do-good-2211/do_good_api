require "rails_helper"

RSpec.describe "User Request Spec" do
  describe "users request" do
    it "can get a list of users" do
      create_list(:user, 3)
      user_data_keys = [:id, :type, :attributes]

      get "/api/v1/users"

      expect(response).to be_successful

      users = JSON.parse(response.body, symbolize_names: true)

      expect(users).to have_key(:data)
      expect(users).to be_a(Hash)
      expect(users[:data]).to be_an(Array)
      expect(users[:data].count).to eq(3)

      users[:data].each do |user|
        expect(user.keys).to eq(user_data_keys)
        expect(user[:id].to_i).to be_an(Integer)
        expect(user[:type]).to eq("users")
        expect(user).to have_key(:attributes)
        expect(user[:attributes]).to be_a(Hash)
        expect(user[:attributes]).to have_key(:name)
        expect(user[:attributes][:name]).to be_a(String)
      end
    end

    it "returns empty data when no users are in the system" do
      get "/api/v1/users"

      expect(response).to be_successful

      users = JSON.parse(response.body, symbolize_names: true)

      expect(users).to have_key(:data)
      expect(users).to be_a(Hash)
      expect(users[:data]).to be_an(Array)
      expect(users[:data].count).to eq(0)
    end
  end

  describe "Get one user" do
    it "can get one user from an id" do
      user = create(:user)
      user_data_keys = [:id, :type, :attributes]

      get "/api/v1/users/#{user.id}"

      expect(response).to be_successful

      user_parsed = JSON.parse(response.body, symbolize_names: true)

      expect(user_parsed).to be_a(Hash)
      expect(user_parsed).to have_key(:data)
      expect(user_parsed[:data].keys).to eq(user_data_keys)
      expect(user_parsed[:data][:attributes].keys).to eq([:name, :email, :password, :good_deeds])
      expect(user_parsed[:data][:attributes][:good_deeds]).to be_an(Array)
      expect(user_parsed[:data][:attributes][:good_deeds].count).to eq(0)
    end

    it "can be have an array of good deeds" do
      user = create(:user)
      host = create(:user)
      good_deed1 = create(:good_deed, host_id: host.id)
      good_deed2 = create(:good_deed, host_id: host.id)
      user_good_deed1 = create(:user_good_deed, user_id: user.id, good_deed_id: good_deed1.id)
      user_good_deed2 = create(:user_good_deed, user_id: user.id, good_deed_id: good_deed2.id)

      expect(user.good_deeds).to eq([good_deed1, good_deed2])

      get "/api/v1/users/#{user.id}"

      expect(response).to be_successful

      user_parsed = JSON.parse(response.body, symbolize_names: true)

      expect(user_parsed[:data][:attributes][:good_deeds]).to be_an(Array)
      expect(user_parsed[:data][:attributes][:good_deeds].count).to eq(2)
      expect(user_parsed[:data][:attributes][:good_deeds].first[:name]).to eq(good_deed1.name)
      expect(user_parsed[:data][:attributes][:good_deeds].second[:name]).to eq(good_deed2.name)
    end

    it "renders an error if a user id that doesn't exist is provided in the query" do 
      get "/api/v1/users/900000000"

      expect(response.status).to eq(404)

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to eq({
                                    "errors":  
                                    [
                                      {
                                        "status": "404",
                                        "title": "Invalid Request",
                                        "detail": 
                                          [
                                            "Couldn't find User with 'id'=900000000"
                                          ]
                                      }
                                    ]
                                  })
    end
  end
end