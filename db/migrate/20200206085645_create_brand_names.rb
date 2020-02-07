class CreateBrandNames < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_names do |t|
      t.string :name, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
