class WeatherFacade
  
  def initialize(coordinates)
    @coordinates = coordinates[:results].first[:locations].first[:latLng]
    @service = WeatherService.new
  end

  def find_five_day_weather
    response = @service.get_five_day_weather(@coordinates)
    current_weather = {
      last_updated: response[:current][:last_updated],
      temperature: response[:current][:temp_f],
      feels_like: response[:current][:feelslike_f],
      humidity: response[:current][:humidity],
      uvi: response[:current][:uv],
      visibility: response[:current][:vis_miles],
      condition: response[:current][:condition][:text],
      icon: response[:current][:condition][:icon]
    }

    daily_weather = response[:forecast][:forecastday].map do |day| {
      date: day[:date],
      sunrise: day[:astro][:sunrise],
      sunset: day[:astro][:sunset],
      max_temp: day[:day][:maxtemp_f],
      min_temp: day[:day][:mintemp_f],
      condition: day[:day][:condition][:text],
      icon: day[:day][:condition][:icon]
    }
    end

    hourly_weather = response[:forecast][:forecastday].first[:hour].map do |hour| {
      time: hour[:time],
      temperature: hour[:temp_f],
      conditions: hour[:condition][:text],
      icon: hour[:condition][:icon]
    }  
    end
    Weather.new(current_weather, daily_weather, hourly_weather)
  end
end