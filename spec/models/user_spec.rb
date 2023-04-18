require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :role }
    it { should validate_presence_of :email }
    it { should validate_presence_of :uid }

    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :uid }

    it { should define_enum_for(:role).with_values([:user, :admin]) }
  end

  describe "relationships" do
    it { should have_many :user_good_deeds }
    it { should have_many(:good_deeds).through(:user_good_deeds) }
  end

  describe "class methods" do
    describe '.from_omniauth' do
      it 'finds or creates a user' do
        user_hash = {
          provider: "google_oauth2",
          uid: "100000000000000000000",
          info: {
            name: "John Smith",
            email: "john@example.com",
            first_name: "John",
            last_name: "Smith",
            image: "https://lh4.googleusercontent.com/photo.jpg",
            urls: {
              google: "https://plus.google.com/+JohnSmith"
            }
          }
        }

        expect(User.from_omniauth(user_hash)).to be_a User
        user = User.from_omniauth(user_hash)

        expect(user.uid).to eq('100000000000000000000')
        expect(user.provider).to eq('google_oauth2')
        expect(user.name).to eq('John Smith')
        expect(user.email).to eq('john@example.com')
      end
    end
  end
end
