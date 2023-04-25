class ActivityFacade
  def initialize(location)
    @location = location
    @coordinates = MapquestFacade.new.find_coordinates(location)
    @activity_service = ActivityService.new
    @weather_facade = WeatherFacade.new(@coordinates)
  end

  def find_activity
    current_weather = @weather_facade.find_five_day_weather
    temperature = current_weather.current_weather[:temperature]
    relaxation_activity = @activity_service.get_activities("relaxation")
    recreational_activity = @activity_service.get_activities("recreational")
    busywork_activity = @activity_service.get_activities("busywork")
    cooking_activity = @activity_service.get_activities("cooking")

    activities = []
    activities << relaxation_activity
    if temperature >= 60
      activities << recreational_activity
    elsif temperature >= 50 && temperature < 60
      activities << busywork_activity
    else
      activities << cooking_activity
    end

    destination = @location,
    forecast = { 
      summary: current_weather.current_weather[:condition],
      temperature: current_weather.current_weather[:temperature]
    }
    activities = activities
    Activity.new(destination, forecast, activities)
  end
end