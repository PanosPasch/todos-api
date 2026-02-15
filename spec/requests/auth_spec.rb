require "rails_helper"

RSpec.describe "Auth", type: :request do
  let!(:user) { User.create!(email: "me@example.com", password: "Password1!", password_confirmation: "Password1!") }

  describe "POST /auth/login" do
    it "returns token for valid credentials" do
      post "/auth/login", params: { user: { email: "me@example.com", password: "Password1!" } }

      expect(response).to have_http_status(:ok)
      expect(json["token"]).to be_present
    end

    it "returns 401 for invalid credentials" do
      post "/auth/login", params: { user: { email: "me@example.com", password: "wrong" } }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /auth/logout" do
    it "revokes token" do
      token = TokenService.issue_for!(user)

      get "/auth/logout", headers: { "Authorization" => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)

      # same token now invalid
      get "/auth/logout", headers: { "Authorization" => "Bearer #{token}" }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
