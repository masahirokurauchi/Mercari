class CreateBrandnameBrandgroups < ActiveRecord::Migration[5.2]
  def change
    create_table :brandname_brandgroups do |t|
      t.integer :brand_name_id, limit: 6, null: false
      t.integer :brand_group_id, limit: 6, null: false
      t.timestamps null: false
    end
    add_foreign_key :brandname_brandgroups, :brand_names
    add_foreign_key :brandname_brandgroups, :brand_groups
  end
end
