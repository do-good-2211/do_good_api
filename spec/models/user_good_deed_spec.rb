require 'rails_helper'

RSpec.describe UserGoodDeed, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to :good_deed }
  end
end
