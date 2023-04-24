class SalariesFacade 
  def initialize(location)
    @location = location
    coordinates = MapquestFacade.new.find_coordinates(location)
    @service = SalariesService.new 
    @weather_facade = WeatherFacade.new(coordinates)
  end

  def find_salaries_and_forecast
    job_titles = ["Data Analyst","Data Scientist","Mobile Developer","QA Engineer","Software Engineer","Systems Administrator","Web Developer"]
    response = @service.get_city_salaries(@location)
    salaries = response[:salaries].map do |salary|
      if job_titles.include?(salary[:job][:title])
        title = salary[:job][:title]
        min = salary[:salary_percentiles][:percentile_25]
        max = salary[:salary_percentiles][:percentile_75]
        Salary.new(title, min, max)
      end
    end.compact
    forecast = @weather_facade.find_five_day_weather
    { 
      destination: @location,
      forecast: {
        summary: forecast.current_weather[:condition],
        temperature: forecast.current_weather[:temperature]
      },
      salaries: salaries
    }
  end
end