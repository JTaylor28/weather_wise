require "rails_helper"

RSpec.describe "Weather Request" do
  describe "GET /api/v0/forecast" do
    it " gets forecasts for a given location " do
      VCR.use_cassette("weather_request") do
        get "/api/v0/forecast?location=cincinatti,oh", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
        
        headers = response.request.headers.to_h.deep_symbolize_keys

        expect(headers[:CONTENT_TYPE]).to eq("application/json")
        expect(headers[:HTTP_ACCEPT]).to eq("application/json")

        forecast = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(forecast[:data]).to be_a(Hash)
        expect(forecast[:data].keys).to eq([:id, :type, :attributes])
        expect(forecast[:data][:id]).to eq(nil)
        expect(forecast[:data][:type]).to eq("forecast")
        expect(forecast[:data][:attributes]).to be_a(Hash)
        expect(forecast[:data][:attributes].keys).to eq([
                                                      :current_weather, 
                                                      :daily_weather, 
                                                      :hourly_weather
                                                      ])

        expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
        expect(forecast[:data][:attributes][:current_weather].keys).to eq([
                                                                        :last_updated, 
                                                                        :temperature, 
                                                                        :feels_like, 
                                                                        :humidity, 
                                                                        :uvi,
                                                                        :visibility,
                                                                        :condition,
                                                                        :icon
                                                                        ])
  
        expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
        expect(forecast[:data][:attributes][:daily_weather][0]).to be_a(Hash)
        expect(forecast[:data][:attributes][:daily_weather][0].keys).to eq([
                                                                      :date,
                                                                      :sunrise,
                                                                      :sunset,
                                                                      :max_temp,
                                                                      :min_temp,
                                                                      :condition,
                                                                      :icon
                                                                      ])
  
        expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
        expect(forecast[:data][:attributes][:hourly_weather][0]).to be_a(Hash)
        expect(forecast[:data][:attributes][:hourly_weather][0].keys).to eq([
                                                                      :time,
                                                                      :temperature,
                                                                      :conditions,
                                                                      :icon
                                                                      ])
      end
    end
  end
end