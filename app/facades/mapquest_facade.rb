class MapquestFacade

  def find_coordinates(location)
    service = MapquestService.new
    coordinates = service.get_lat_long(location)
  end

end