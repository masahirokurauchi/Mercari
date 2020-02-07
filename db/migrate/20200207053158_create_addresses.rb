class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :phone_number, null: true
      t.string :postal_code, null: true
      t.integer :prefecture, null: true
      t.string :city, null: true
      t.string :house_number, null: true
      t.string :building_name, null: true
      t.integer :user_id, limit: 6, null: true, foreign_key: true
      t.timestamps null: true
    end
  end
end
