require 'rails_helper'

RSpec.describe GoodDeed, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :host_id }
    it { should validate_presence_of :date }
    it { should validate_presence_of :time }
    it { should validate_presence_of :status }

    it { should define_enum_for(:status).with_values(["In Progress", "Completed"]) }
  end

  describe "relationships" do
    it { should have_many :user_good_deeds }
    it { should have_many(:users).through(:user_good_deeds) }
  end

  describe "instance methods" do
    context "#add_participants" do
      before(:each) do
        @users = create_list(:user, 4)
        @good_deed1 = create(:good_deed, host_id: @users[0].id)
      end

      it "can create a join table record of all participants of a good deed" do
        invitee_array = ([{ "user_id"=>@users[1].id }, { "user_id"=>@users[2].id }])
        host_id = @users[0].id

        @good_deed1.add_participants(invitee_array, host_id)

        expect(UserGoodDeed.last.user_id).to eq(@users[0].id)
        expect(UserGoodDeed.all.count).to eq(3)
      end
    end
  end
end
