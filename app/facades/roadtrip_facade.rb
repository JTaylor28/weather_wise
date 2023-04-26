class RoadtripFacade
 
  def self.get_roadtrip_info(origin, destination)
    service = RoadtripService.new.get_directions(origin, destination)
    if service[:info][:statuscode] == 402
      travel_time = "impossible"
      weather_at_eta = {}
			return Roadtrip.new(origin, destination, travel_time, weather_at_eta)
    end
    travel_time = service[:route][:formattedTime]

    map_q_response = MapquestFacade.new.find_coordinates(destination)
    coordinates = map_q_response[:results].first[:locations].first[:latLng]
    forecast = WeatherService.new.get_five_day_weather(coordinates)
    arrival_date = Time.at(Time.now.to_i + service[:route][:realTime]).strftime('%Y-%m-%d')
    arrival_time = Time.at(Time.now.to_i + service[:route][:realTime])
    arrival_minute = arrival_time.min
    if arrival_minute >= 30
      arrival_time += 1.hour
    end
    arrival_hour = arrival_time.hour
    forecast[:forecast][:forecastday].each do |day|
      if day[:date] == arrival_date
        day[:hour].each do |hour|
          hourly_forecast_time = Time.parse(hour[:time])
          if hourly_forecast_time.hour == arrival_hour
            weather_at_eta = {
              datetime: hour[:time],
              temperature: hour[:temp_f],
              condition: hour[:condition][:text]
            }
            return Roadtrip.new(origin, destination, travel_time, weather_at_eta)
          end 
        end 
      end
    end 
  end
end