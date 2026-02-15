class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  private

  def authenticate!
    header = request.headers["Authorization"].to_s
    token = header.start_with?("Bearer ") ? header.delete_prefix("Bearer ").strip : nil

    return json_response({ error: "Unauthorized" }, :unauthorized) if token.blank?

    digest = TokenService.digest(token)
    access = AccessToken.active.find_by(token_digest: digest)

    return json_response({ error: "Unauthorized" }, :unauthorized) if access.nil?

    @current_user = access.user
    @current_access_token = access
  end

  def current_user = @current_user
  def current_access_token = @current_access_token
end
