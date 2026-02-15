class SignupController < ApplicationController
  def create
    user = User.new(signup_params)
    user.email = user.email.to_s.downcase

    user.save! # αν αποτύχει, πιάνεται από RecordInvalid => 422

    token = TokenService.issue_for!(user)
    json_response({ token: token }, :created)
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
