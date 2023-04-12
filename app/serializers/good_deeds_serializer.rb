# frozen_string_literal: true

# app/serializers/good_deeds_serializer.rb
class GoodDeedsSerializer
  include JSONAPI::Serializer
  attributes :name, :media_link, :notes, :date, :time, :status, :host_id
end