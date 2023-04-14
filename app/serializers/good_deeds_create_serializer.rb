class GoodDeedsCreateSerializer
  include JSONAPI::Serializer
  attributes :name, :media_link, :notes, :date, :time, :status, :host_id
end
