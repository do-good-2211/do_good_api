class GoodDeedSerializer
  include JSONAPI::Serializer
  attributes :name, :date, :time, :status, :notes, :media_link

  attributes :attendees do |object| 
    object.attendees
  end
end
