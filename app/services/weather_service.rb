class WeatherService

  def get_five_day_weather(coordinates)
    get_url("forecast.json?q=#{coordinates[:lat]},#{coordinates[:lng]}&days=5")
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
    Faraday.new(url: 'http://api.weatherapi.com/v1') do |req|
      req.params['key'] = ENV['WEATHER_API_KEY']
    end
  end
end