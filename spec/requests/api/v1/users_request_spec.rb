require "rails_helper"

RSpec.describe "User Request Spec" do
  describe "users request" do
    it "can get a list of users" do
      users = create_list(:user, 3)
      # good_deed = create(:good_deed, host_id: users[0].id)
    end
  end
end
