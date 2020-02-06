class CreateCategoryBrandgroups < ActiveRecord::Migration[5.2]
  def change
    create_table :category_brandgroups do |t|
      t.integer :category_id, limit: 6, null: false, foreign_key: true
      t.integer :brand_group_id, limit: 6, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
