class CreateCategorySizegroups < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sizegroups do |t|
      t.integer :category_id, limit: 6, null: false
      t.integer :size_group_id, limit: 6, null: false
      t.timestamps null: false
    end
    add_foreign_key :category_sizegroups, :categories
    add_foreign_key :category_sizegroups, :size_groups
  end
end
