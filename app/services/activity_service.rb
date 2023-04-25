class ActivityService

  def get_activities(city)
    get_url("activities?city=#{city}")
  end


  private

  def get_url(url)
    response = conn.get(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://boardapi.com/api/")
  end

end