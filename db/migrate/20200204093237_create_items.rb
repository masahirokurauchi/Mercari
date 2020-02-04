class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, foreign_key: true
      t.integer :price, null: false
      t.text :detail, null: false
      t.integer :condition, null: false
      t.integer :delivery_fee_payer, null: false
      t.integer :delivery_method, null: false
      t.integer :delivery_agency, null: false
      t.integer :delivery_days, null: false
      t.integer :deal, null: true, default: 0
      t.integer :category_id, limit: 6, null: false, foreign_key: true
      t.integer :seller_id, limit: 6, null: false, foreign_key: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false 
    end
  end
end
