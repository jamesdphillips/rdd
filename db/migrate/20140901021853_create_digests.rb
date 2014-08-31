class CreateDigests < ActiveRecord::Migration
  def change
    create_table(:digests) do |t|
      t.integer :account_id, null: false
      t.string :subreddits, array: true, default: []
      t.string :keywords, array: true, default: []

      t.timestamps
    end

    add_index :digests, :account_id
  end
end
