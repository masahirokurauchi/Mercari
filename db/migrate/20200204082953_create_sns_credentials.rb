class CreateSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_credentials do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.integer :user_id, null: false, limit: 6
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
    add_foreign_key :sns_credentials, :users
  end
end
