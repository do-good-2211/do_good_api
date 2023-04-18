# frozen_string_literal: true

# app/serializers/users_acts_serializer.rb
class UsersSerializer
  include JSONAPI::Serializer
  attributes :name, :role, :email #:good_deeds, :email

  attributes :good_deeds do |object|
    # require 'pry'; binding.pry
    GoodDeedSerializer.new(object.good_deeds)
  end
end
