require 'rails_helper'

RSpec.describe "Good Deeds Controller" do
  describe "#create" do
    before(:each) do
      @users = create_list(:user, 4)
      @good_deed_params = { 
        deed_name: "Wash neighbor's car.", 
        date: "01-01-2023", 
        time: "17:00", 
        attendees: [{ "user_id": @users[1].id }, { "user_id": @users[2].id }] 
      }
    end

    describe "when sucessful" do 
      it "creates a new Good Deed record" do
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/users/#{@users[0].id}/good_deeds", headers: headers, params: JSON.generate(@good_deed_params)

        expect(response).to be_successful
        
        parsed_data = JSON.parse(response.body, symbolize_names: true)
        require 'pry'; binding.pry

        expect(parsed_data).to be_a(Hash)
      end

      xit "creates a new User Good Deed records" do
        get "/api/v1/random_acts"

        expect(response).to be_successful

        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
      end
    end
  end
end