require "rails_helper"

RSpec.describe "/api/vo/users", type: :request do
  describe "POST /create" do
    context "When successful" do
      it "creates a new user" do
        user_params = { email: "email@email.com", password: "goodpassword", password_confirmation: "goodpassword"}
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)
        expect(response).to have_http_status(201)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:id]).to be_a(String)
        expect(parsed[:data][:type]).to eq("users")
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes].keys).to eq([:email, :api_key])
        expect(parsed[:data][:attributes][:email]).to eq("email@email.com")
        expect(parsed[:data][:attributes][:api_key]).to be_a(String)
      end
    end

    context "When unsuccessful" do
      it "returns an error if email is missing" do
        user_params = { email: " ", password: "goodpassword", password_confirmation: "goodpassword" }
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)

        expect(response).to have_http_status(404)

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed[:errors].first[:detail]).to eq(["invalid credentials"])
        expect(parsed[:errors].first[:title]).to eq("Bad Request")
      end

      it "returns an error if password is missing" do
        user_params = { email: "email@email.com", password: "", password_confirmation: ""}
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)

        expect(response).to have_http_status(404)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed[:errors].first[:detail]).to eq(["invalid credentials"])
        expect(parsed[:errors].first[:title]).to eq("Bad Request")
      end

      it "returns an error if password_confirmation does not match password" do
        user_params = { email: "email@email.com ", password: "password", password_confirmation: "wordpass" }
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)

        expect(response).to have_http_status(404)

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed[:errors].first[:detail]).to eq(["invalid credentials"])
        expect(parsed[:errors].first[:title]).to eq("Bad Request")
      end
    end 
  end
end