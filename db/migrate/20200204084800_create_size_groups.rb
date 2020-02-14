class CreateSizeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :size_groups do |t|
      t.string :name, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
  end
end
