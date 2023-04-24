class SalariesFacade 
  def initialize(city)
    @city = city
    @service = SalariesService.new
    @forecast = WeatherFacade.new(city).find_five_day_weather
  end

  def find_salaries_and_forcast
    response = @service.get_city_salaries(@city)
    salaries = response[:salaries].map do |salary|
      require 'pry'; binding.pry
      title = salary[:job].first[:title]
      min = salary[:salary_percentiles][:percentile_25]
      max = salary[:salary_percentiles][:percentile_75]
    end
    Salary.new(title, min, max)
  end
end