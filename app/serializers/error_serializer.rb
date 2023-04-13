# frozen_string_literal: true

# app/serializers/error_serializer.rb
class ErrorSerializer
  def initialize(errors)
    @errors = errors
  end

  def invalid_request
    {
      errors: [
        {
          "status": "404",
          "title": "Invalid Request",
          "detail": [@errors]
        }
      ]
    }
  end
end

