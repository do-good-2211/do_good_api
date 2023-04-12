# frozen_string_literal: true

# app/serializers/random_acts_serializer.rb
class RandomActsSerializer
  include JSONAPI::Serializer
  attributes :deed_names
end
