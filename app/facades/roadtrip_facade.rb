class RoadtripFacade
 
  def self.get_roadtrip_info(origin, destination)
    service = RoadtripService.new.get_directions(origin, destination)
    if service[:info][:statuscode] == 402
      travel_time = service[:info][:messages][0]
      weather_at_eta = {}
			return Roadtrip.new(origin, destination, travel_time, weather_at_eta)
    end
    travel_time = service[:route][:formattedTime]

    coordinates = MapquestFacade.new.find_coordinates(destination)
    forecast = WeatherFacade.new(coordinates).find_five_day_weather
    arrival_date = Time.at(Time.now.to_i + service[:route][:realTime]).strftime('%Y-%m-%d')
    arrival_time = Time.at(Time.now.to_i + service[:route][:realTime])
    arrival_hour = arrival_time.hour
    arrival_minute = arrival_time.min
    if arrival_minute >= 30
      arrival_hour += 1
      arrival_time += 1.hour
    end
    forecast.hourly_weather.each do |hour|
      hourly_forecast_time = Time.parse(hour[:time])
      if hourly_forecast_time.hour == arrival_hour
        weather_at_eta = {
          datetime: hour[:time],
          temperature: hour[:temperature],
          condition: hour[:conditions]
        }
        return Roadtrip.new(origin, destination, travel_time, weather_at_eta)
      end 
    end
  end
end