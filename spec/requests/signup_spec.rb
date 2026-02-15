require "rails_helper"

RSpec.describe "Signup", type: :request do
  describe "POST /signup" do
    it "creates a user and returns a token" do
      post "/signup", params: {
        user: { email: "test@example.com", password: "Password1!", password_confirmation: "Password1!" }
      }

      expect(response).to have_http_status(:created)
      expect(json["token"]).to be_present
    end

    it "returns 422 when invalid" do
      post "/signup", params: { user: { email: "", password: "x", password_confirmation: "y" } }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
