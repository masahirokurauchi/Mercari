class CreateCategoryBrandgroups < ActiveRecord::Migration[5.2]
  def change
    create_table :category_brandgroups do |t|
      t.integer :category_id, limit: 6, null: false
      t.integer :brand_group_id, limit: 6, null: false, foreign_key: true
      t.timestamps null: false
    end
    add_foreign_key :category_brandgroups, :categories
    add_foreign_key :category_brandgroups, :brand_groups
  end
end
