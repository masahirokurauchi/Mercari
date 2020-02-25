# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, null: false
      t.string :encrypted_password, null: false, default: ""
      t.string :nickname, null: false
      t.string :avatar
      t.text :introduction
      t.string :first_name, null: false
      t.string :first_name_reading, null: false
      t.string :last_name, null: false
      t.string :last_name_reading, null: false
      t.date :birthday, null: false
      t.integer :earnings, default: 0
      t.integer :points, default: 0

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
