require 'rails_helper' 

RSpec.describe WeatherFacade, type: :facade do

  describe 'find_five_day_weather' do

    it "returns five days of weather for a location based on coordinates" do
      VCR.use_cassette('weather_facade') do
        coordinates = MapquestFacade.new.find_coordinates('denver,co')
        facade = WeatherFacade.new(coordinates)
        results = facade.find_five_day_weather

        expect(results).to be_a(Weather)
        expect(results.daily_weather.count).to eq(5)
        expect(results.current_weather[:last_updated]).to eq("2023-04-23 21:45")
        expect(results.current_weather[:temperature]).to eq(43.5)
        expect(results.current_weather[:feels_like]).to eq(40.5)
        expect(results.current_weather[:humidity]).to eq(50)
        expect(results.current_weather[:uvi]).to eq(1.0)
        expect(results.current_weather[:visibility]).to eq(9.0)
        expect(results.current_weather[:condition]).to eq("Partly cloudy")
        expect(results.current_weather[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/116.png")
      end
    end
  end 
end