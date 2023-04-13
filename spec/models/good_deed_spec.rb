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
        users = create_list(:user, 4)
        @good_deed1 = create(:good_deed, host_id: users[0].id)
        @host_id = users[0].id
        @invitee1 = users[1]
        @invitee2 = users[2]
      end

      describe "Happy Path Tests" do
        it "can create a join table record of all participants of a good deed" do
          invitee_array = ([{ "user_id"=>@invitee1.id }, { "user_id"=>@invitee2.id }])

          @good_deed1.add_participants(invitee_array, @host_id)

          expect(UserGoodDeed.last.user_id).to eq(@host_id)
          expect(UserGoodDeed.all.count).to eq(3)
        end

        it "can create a join table record of ONLY host participants of a good deed" do
          invitee_array = ([])

          @good_deed1.add_participants(invitee_array, @host_id)

          expect(UserGoodDeed.last.user_id).to eq(@host_id)
          expect(UserGoodDeed.all.count).to eq(1)
        end
      end

      describe "Sad Path Tests" do
        it "cannot create a join table record when host_id is invalid" do
          invitee_array = ([])
          invalid_id = 0

          expect{@good_deed1.add_participants(invitee_array, invalid_id)}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "cannot create a join table record when host_id is nil" do
          invitee_array = ([])
          invalid_id = nil

          expect{@good_deed1.add_participants(invitee_array, invalid_id)}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
