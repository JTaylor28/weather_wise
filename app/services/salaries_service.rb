class SalariesService 

  def get_city_salaries(city)
    get_url("urban_areas/slug:#{city}/salaries")
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
    Faraday.new(url: 'https://api.teleport.org/api/')
  end
end