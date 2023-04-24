class SalariesFacade 
  def initialize(city,state)
    city_state = city+","+state
    coordinates = MapquestFacade.new.find_coordinates(city_state)
    @city = city
    @service = SalariesService.new 
    @weather_facade = WeatherFacade.new(coordinates)
  end

  def find_salaries_and_forecast
    response = @service.get_city_salaries(@city)
    salaries = response[:salaries].map do |salary|
      title = salary[:job][:title]
      min = salary[:salary_percentiles][:percentile_25]
      max = salary[:salary_percentiles][:percentile_75]
      Salary.new(title, min, max)
    end
    forecast = @weather_facade.find_five_day_weather
    { 
      destination: @city,
      forecast: {
        summary: forecast.current_weather[:condition],
        temperature: forecast.current_weather[:temperature]
      },
      salaries: salaries
    }
  end
end