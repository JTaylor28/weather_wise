require "rails_helper"

RSpec.describe "Road Trip Request" do
  describe "POST /api/v0/road_trip" do
   context "when successful" do
      it " returns a hash with road trip information" do
        VCR.use_cassette("road_trip_request") do
          api_key = SecureRandom.hex(16)
          user = User.create(email: "email@example.com", password: "awesomepassword", password_confirmation: "awesomepassword", api_key: api_key)
          valid_params = { origin: "Denver,CO", destination: "Pueblo,CO", api_key: user.api_key }

          post "/api/v0/road_trip", params: valid_params.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
          
          headers = response.request.headers.to_h.deep_symbolize_keys

          expect(headers[:CONTENT_TYPE]).to eq("application/json")
          expect(headers[:HTTP_ACCEPT]).to eq("application/json")

          road_trip = JSON.parse(response.body, symbolize_names: true)
          expect(response).to be_successful
          expect(road_trip[:data]).to be_a(Hash)
          expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
          expect(road_trip[:data][:id]).to eq(nil)
          expect(road_trip[:data][:type]).to eq("roadtrip")
          expect(road_trip[:data][:attributes]).to be_a(Hash)
          expect(road_trip[:data][:attributes].keys).to eq([:start_city, 
                                                            :end_city, 
                                                            :travel_time, 
                                                            :weather_at_eta])
          expect(road_trip[:data][:attributes][:start_city]).to eq(valid_params[:origin])
          expect(road_trip[:data][:attributes][:end_city]).to eq(valid_params[:destination])
          expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
          expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
          expect(road_trip[:data][:attributes][:weather_at_eta].keys).to eq([ :datetime, 
                                                                              :temperature, 
                                                                              :condition])
          expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
          expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
          expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
        end 
      end 
    end

    context "when unsuccessful" do
      it "returns an error message if api_key is invalid" do
        VCR.use_cassette("road_trip_request") do
          api_key = SecureRandom.hex(16)
          user = User.create(email: "email@example.com", password: "password", password_confirmation: "password", api_key: api_key)
          invalid_params = { origin: "Denver,CO", destination: "Pueblo,CO", api_key: "not the api key" }

          post "/api/v0/road_trip", params: invalid_params.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

          headers = response.request.headers.to_h.deep_symbolize_keys
          road_trip = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status(401)
          expect(road_trip[:error]).to eq('Invalid API')
        end 
      end 

      it "returns a hash with road trip information for impossible routes" do
        VCR.use_cassette("road_trip_request_impossible") do
          api_key = SecureRandom.hex(16)
          user = User.create(email: "email@example.com", password: "awesomepassword", password_confirmation: "awesomepassword", api_key: api_key)
          impossible_params = { origin: "Denver,CO", destination: "London,UK", api_key: user.api_key }

          post "/api/v0/road_trip", params: impossible_params.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
          
          headers = response.request.headers.to_h.deep_symbolize_keys

          expect(headers[:CONTENT_TYPE]).to eq("application/json")
          expect(headers[:HTTP_ACCEPT]).to eq("application/json")

          road_trip = JSON.parse(response.body, symbolize_names: true)
          expect(response).to be_successful
          expect(road_trip[:data]).to be_a(Hash)
          expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
          expect(road_trip[:data][:id]).to eq(nil)
          expect(road_trip[:data][:type]).to eq("roadtrip")
          expect(road_trip[:data][:attributes]).to be_a(Hash)
          expect(road_trip[:data][:attributes].keys).to eq([:start_city, 
                                                            :end_city, 
                                                            :travel_time, 
                                                            :weather_at_eta])
          expect(road_trip[:data][:attributes][:start_city]).to eq(impossible_params[:origin])
          expect(road_trip[:data][:attributes][:end_city]).to eq(impossible_params[:destination])
          expect(road_trip[:data][:attributes][:travel_time]).to eq("impossible")
          expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
        end
      end
    end 
  end
end