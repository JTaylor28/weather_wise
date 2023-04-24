require "rails_helper"

RSpec.describe WeatherService, type: :service do
  describe "get_five_day_weather" do
    it "can get weather based on location lat and long for five days" do
      VCR.use_cassette("weather_service") do
        coordinates = ({:lat=>39.738453, :lng=>-104.984853})
        weather = WeatherService.new.get_five_day_weather(coordinates)
        expect(weather).to be_a(Hash)
        expect(weather[:location]).to be_a(Hash)
        expect(weather[:current]).to be_a(Hash)
        expect(weather[:current].keys).to eq([:last_updated, :temp_f, :condition, :humidity, :feelslike_f, :vis_miles, :uv])
        expect(weather[:current][:last_updated]).to be_a(String)
        expect(weather[:current][:temp_f]).to be_a(Float)
        expect(weather[:current][:humidity]).to be_a(Integer)
        expect(weather[:current][:feelslike_f]).to be_a(Float)
        expect(weather[:current][:vis_miles]).to be_a(Float)
        expect(weather[:current][:condition]).to be_a(Hash)
        expect(weather[:current][:condition].keys).to eq([:text, :icon])
        expect(weather[:current][:condition][:text]).to be_a(String)
        expect(weather[:current][:condition][:icon]).to be_a(String)
        expect(weather[:forecast][:forecastday]).to be_a(Array)
        expect(weather[:forecast][:forecastday].count).to eq(5)
        weather[:forecast][:forecastday].each do |day|
          expect(day).to be_a(Hash)
          expect(day[:date]).to be_a(String)
          expect(day[:day]).to be_a(Hash)
          expect(day[:day][:maxtemp_f]).to be_a(Float)
          expect(day[:day][:mintemp_f]).to be_a(Float)
          expect(day[:day][:condition]).to be_a(Hash)
          expect(day[:day][:condition].keys).to eq([:text, :icon])
          expect(day[:day][:condition][:text]).to be_a(String)
          expect(day[:day][:condition][:icon]).to be_a(String)
          expect(day[:astro]).to be_a(Hash)
          expect(day[:astro][:sunrise]).to be_a(String)
          expect(day[:astro][:sunset]).to be_a(String)
          day[:hour].each do |hour|
            expect(hour).to be_a(Hash)
            expect(hour[:time]).to be_a(String)
            expect(hour[:temp_f]).to be_a(Float)
            expect(hour[:condition]).to be_a(Hash)
            expect(hour[:condition].keys).to eq([:text, :icon])
            expect(hour[:condition][:text]).to be_a(String)
            expect(hour[:condition][:icon]).to be_a(String)
          end
        end
      end
    end
  end
end