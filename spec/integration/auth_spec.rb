require "swagger_helper"

RSpec.describe "Auth API", swagger_doc: "v1/swagger.yaml", type: :request do
  path "/signup" do
    post "Signup" do
      tags "Auth"
      consumes "application/json"
      produces "application/json"

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: "me@example.com" },
              password: { type: :string, example: "Password1!" },
              password_confirmation: { type: :string, example: "Password1!" }
            },
            required: %w[email password password_confirmation]
          }
        },
        required: ["user"]
      }

      response "201", "created" do
        let(:payload) do
          { user: { email: "me@example.com", password: "Password1!", password_confirmation: "Password1!" } }
        end
        run_test!
      end

      response "422", "invalid" do
        let(:payload) do
          { user: { email: "", password: "x", password_confirmation: "y" } }
        end
        run_test!
      end
    end
  end

  path "/auth/login" do
    post "Login" do
      tags "Auth"
      consumes "application/json"
      produces "application/json"

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: "me@example.com" },
              password: { type: :string, example: "Password1!" }
            },
            required: %w[email password]
          }
        },
        required: ["user"]
      }

      response "200", "ok" do
        let!(:user) { User.create!(email: "me@example.com", password: "Password1!", password_confirmation: "Password1!") }
        let(:payload) { { user: { email: "me@example.com", password: "Password1!" } } }
        run_test!
      end

      response "401", "invalid credentials" do
        let(:payload) { { user: { email: "me@example.com", password: "wrong" } } }
        run_test!
      end
    end
  end

  path "/auth/logout" do
    get "Logout" do
      tags "Auth"
      produces "application/json"
      security [{ bearerAuth: [] }]

      parameter name: :Authorization, in: :header, type: :string, required: true, description: "Bearer <token>"

      response "200", "ok" do
        let!(:user) { User.create!(email: "me@example.com", password: "Password1!", password_confirmation: "Password1!") }
        let(:token) { TokenService.issue_for!(user) }
        let(:Authorization) { "Bearer #{token}" }
        run_test!
      end

      response "401", "unauthorized" do
        let(:Authorization) { "Bearer invalid" }
        run_test!
      end
    end
  end
end
