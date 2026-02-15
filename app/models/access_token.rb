class AccessToken < ApplicationRecord
  belongs_to :user

  validates :token_digest, presence: true, uniqueness: true
  scope :active, -> { where(revoked_at: nil) }

  def revoke!
    update!(revoked_at: Time.current)
  end
end
