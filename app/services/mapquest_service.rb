class MapquestService

  def get_lat_long(location)
    get_url("address?location=#{location}")
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
    Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/') do |req|
      req.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

end