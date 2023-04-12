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
end
