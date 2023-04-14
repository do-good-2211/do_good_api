# frozen_string_literal: true

# app/serializers/users_acts_serializer.rb
class UsersSerializer
  include JSONAPI::Serializer
  attributes :name, :role, :good_deeds
end
