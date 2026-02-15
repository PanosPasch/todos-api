class CreateAccessTokens < ActiveRecord::Migration[8.1]
  def change
    create_table :access_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token_digest
      t.datetime :revoked_at

      t.timestamps
    end
  end
end
