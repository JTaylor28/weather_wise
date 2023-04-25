class ErrorSerializer
  def initialize(errors)
    @errors = errors
  end

  def invalid_request
    {
      errors: [
        {
          "status": "404",
          "title": "Bad Request",
          "detail": [@errors]
        }
      ]
    }
  end

  def bad_credentials
    {
      errors: [
        {
          "status": "401",
          "title": "Unauthorized",
          "detail": [@errors]
        }
      ]
    }
  end
end
