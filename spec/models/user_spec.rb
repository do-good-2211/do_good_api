require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :role }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it { should validate_uniqueness_of :email }
    it { should have_secure_password }

    it { should define_enum_for(:role).with_values([:user, :admin]) }
  end

  describe "relationships" do
    it { should have_many :user_good_deeds }
    it { should have_many(:good_deeds).through(:user_good_deeds) }
  end
end
