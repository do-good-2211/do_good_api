FactoryBot.define do
  factory :user do
    name { Faker::Superhero.name }
    email { Faker::Internet.email }
    uid { Faker::IDNumber.brazilian_citizen_number }
  end
end
