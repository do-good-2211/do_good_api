FactoryBot.define do 
  factory :user_good_deed do 
    association :user
    association :good_deed
  end
end