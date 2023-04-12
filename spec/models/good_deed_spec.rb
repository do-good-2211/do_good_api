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
end
