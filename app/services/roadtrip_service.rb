class RoadtripService
  URL = "https://www.mapquestapi.com/directions/v2/route"

  def get_directions(origin, destination) 
    faraday = Faraday.new(url: URL) do |f|
      f.params["key"] = ENV["MAPQUEST_API_KEY"]
      f.params["from"] = origin
      f.params["to"] = destination
    end

    response = faraday.get
    results = JSON.parse(response.body, symbolize_names: true)
  end
end