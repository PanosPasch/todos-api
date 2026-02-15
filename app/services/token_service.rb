require "digest"

class TokenService
  def self.issue_for!(user)
    plain = SecureRandom.hex(32)
    digest = Digest::SHA256.hexdigest(plain)
    user.access_tokens.create!(token_digest: digest)
    plain
  end

  def self.digest(token)
    Digest::SHA256.hexdigest(token)
  end
end
