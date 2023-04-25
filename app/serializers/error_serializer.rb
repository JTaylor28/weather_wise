class ErrorSerializer
  def initialize(errors)
    @errors = errors
  end

  def bad_request
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
end
