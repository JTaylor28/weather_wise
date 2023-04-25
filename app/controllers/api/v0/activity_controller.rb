class Api::V0::ActivityController < ApplicationController
  def index 
    location = ActivityFacade.new(params[:location]).find_activity
    render json: ActivitySerializer.format_resource(location)
  end
end