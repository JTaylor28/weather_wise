class Api::V0::RoadTripController < ApplicationController
  def create
    @user = User.find_by(api_key: trip_params[:api_key])
    if @user
      trip = RoadtripFacade.get_roadtrip_info(params[:origin], params[:destination])
      render json: RoadtripSerializer.new(trip), status: 200
    else 
      render json: { error: 'Invalid API' }, status: 401
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end 