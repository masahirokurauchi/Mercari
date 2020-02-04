class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :encrypted_password, null: false
      t.string :nickname, null: false
      t.string :avatar, null: true
      t.text :introduction, null: false
      t.string :first_name, null: false
      t.string :first_name_reading, null: false
      t.string :last_name, null: false
      t.string :last_name_reading, null: false
      t.date :birthday, null: false
      t.integer :earnings, null: true, default: 0
      t.integer :points, null: true, default: 0
      t.string :reset_password_token, null: true, unique: true
      t.datetime :reset_password_sent_at, null: true
      t.datetime :remember_created_at, null: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
  end
end
