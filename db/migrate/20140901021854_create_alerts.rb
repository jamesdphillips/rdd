class CreateAlerts < ActiveRecord::Migration
  def change
    create_table(:alerts) do |t|
      t.integer :account_id, null: false
      t.string :subreddit, null: false
      t.string :keywords, array: true, default: []

      t.timestamps
    end

    add_index :alerts, :account_id
    add_index :alerts, [:subreddit, :account_id]
  end
end
