class CreateValues < ActiveRecord::Migration[5.2]
  def change
    create_table :values do |t|
      t.bigint(20) :dealing_id, null: true, foreign_key: true
      t.bigint(20) :user_id, null: true, foreign_key: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
  end
end
