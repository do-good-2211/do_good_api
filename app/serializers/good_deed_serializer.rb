class GoodDeedSerializer
  include JSONAPI::Serializer
  attributes :name, :date, :time, :status, :notes, :media_link
end
