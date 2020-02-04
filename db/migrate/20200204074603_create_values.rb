class CreateValues < ActiveRecord::Migration[5.2]
  def change
    create_table :values do |t|
      t.integer :dealing_id, null: true, foreign_key: true, limit: 6
      t.integer :user_id, null: true, foreign_key: true, limit: 6
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
  end
end
