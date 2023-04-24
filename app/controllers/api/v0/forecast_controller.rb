class Api::V0::ForecastController < ApplicationController
  def index
    coordinates = MapquestFacade.new.find_coordinates(params[:location])
    forecast = WeatherFacade.new(coordinates).find_five_day_weather
    render json: ForecastSerializer.new(forecast)
  end
end