require "rails_helper"

RSpec.describe AccessToken, type: :model do
  let!(:user) { User.create!(email: "me@example.com", password: "Password1!", password_confirmation: "Password1!") }

  it "is valid with user and token_digest" do
    token = user.access_tokens.new(token_digest: "abc")
    expect(token).to be_valid
  end

  it "is invalid without token_digest" do
    token = user.access_tokens.new
    expect(token).not_to be_valid
  end

  it "revokes token by setting revoked_at" do
    token = user.access_tokens.create!(token_digest: "abc")
    expect(token.revoked_at).to be_nil
    token.revoke!
    expect(token.revoked_at).to be_present
  end
end
