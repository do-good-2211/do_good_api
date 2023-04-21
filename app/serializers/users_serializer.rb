# frozen_string_literal: true

# app/serializers/users_acts_serializer.rb
class UsersSerializer
  include JSONAPI::Serializer
  attributes :name, :role, :email

  attributes :good_deeds do |object|
    GoodDeedSerializer.new(object.good_deeds)
  end
end
