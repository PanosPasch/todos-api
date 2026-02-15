class AuthController < ApplicationController
  before_action :authenticate!, only: [:logout]

  def login
    email = params.dig(:user, :email).to_s.downcase
    password = params.dig(:user, :password).to_s

    user = User.find_by(email: email)

    if user&.authenticate(password)
      token = TokenService.issue_for!(user)
      json_response({ token: token }, :ok)
    else
      json_response({ error: "Invalid credentials" }, :unauthorized)
    end
  end

  def logout
    current_access_token.revoke!
    json_response({ message: "Logged out" }, :ok)
  end
end
