class Api::V0::SalariesController < ApplicationController
  def index 
    city = SalariesFacade.new(params[:location]).find_salaries_and_forecast
    render json: SalariesSerializer.format_resource(city)
  end
end