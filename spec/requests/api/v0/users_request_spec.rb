require "rails_helper"

RSpec.describe "/api/vo/users", type: :request do
  describe "POST /create" do
    context "When successful" do
      let(:user_params) { { email: "email@email.com", password: "goodpassword", password_confirmation: "goodpassword" } }

      it "creates a new user" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)

        expect(response).to have_http_status(201)

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed).to be_a(Hash)
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])

        expect(parsed[:data][:id]).to be_a(String)
        expect(parsed[:data][:type]).to be_a("users")
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes].keys).to eq([:email, :api_key])
        expect(parsed[:data][:attributes][:email]).to be_a("email@email.com")
        expect(parsed[:data][:attributes][:api_key]).to be_a(String)
      end
    end
  end
end