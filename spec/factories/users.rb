FactoryBot.define do 
  factory :user do 
    name { Faker::Superhero.name }
    password { Faker::Internet.password }
    email { Faker::Internet.email }
  end
end