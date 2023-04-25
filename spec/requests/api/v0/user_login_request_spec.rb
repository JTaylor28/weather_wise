require "rails_helper"

RSpec.describe "/api/vo/sessions", type: :request do
  describe "POST /login" do
    context "When successful" do
      it "logs in an existing user" do
        user = User.create( email: "whatever@example.com", password: "password", password_confirmation: "password")

        login_params = { email: "whatever@example.com", password: "password" }
        headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        post "/api/v0/sessions", headers: headers, params: JSON.generate(login_params)

        expect(response).to have_http_status(200)

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data].keys).to eq([:type, :id, :attributes])
        expect(parsed[:data][:id]).to eq(user.id)
        expect(parsed[:data][:type]).to eq("users")
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes].keys).to eq([:email, :api_key])
        expect(parsed[:data][:attributes][:email]).to eq("whatever@example.com")
        expect(parsed[:data][:attributes][:api_key]).to eq(user.api_key)
      end 
    end 
  end

  context "When unsuccessful" do
    it "returns an error message with a 401 status code" do
      User.create( email: "whatever@example.com", password: "password", password_confirmation: "password")

      login_params = { email: "whatever@example.com", password: "wrongpassword" }
      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
      post "/api/v0/sessions", headers: headers, params: JSON.generate(login_params)

      expect(response).to have_http_status(401)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed).to be_a(Hash)
      expect(parsed[:errors].first[:detail]).to eq(["invalid credentials"])
      expect(parsed[:errors].first[:title]).to eq("Unauthorized")
    end
  end
end