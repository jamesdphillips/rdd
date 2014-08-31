class CreateAccounts < ActiveRecord::Migration
  def change
    create_table(:accounts) do |t|
      # Database authenticatable
      t.string :email, null: false, default: ""

      # Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip

      # Confirmable
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email

      # Preferences
      t.string :timezone
      t.string :preferred_digest_frequency, default: "daily"
      t.integer :preferred_digest_hour, default: 10

      t.timestamps
    end

    add_index :accounts, :email, unique: true
    add_index :accounts, :confirmation_token, unique: true
  end
end
