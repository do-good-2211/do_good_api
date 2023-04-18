class GoodDeedSerializer
  include JSONAPI::Serializer
  attributes :name, :date, :time, :status, :notes, :media_link

  attributes :host_name do |object|
    object.host_name
  end

  attributes :attendees do |object| 
    object.attendees
  end
end
