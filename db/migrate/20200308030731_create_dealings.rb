class CreateDealings < ActiveRecord::Migration[5.2]
  def change
    create_table :dealings do |t|
      t.integer     :phase
      t.datetime    :buyer_datetime
      t.datetime    :seller_datetime
      t.references  :item, forign_key: true
      t.references  :buyer, forign_key: { to_table: :users }
      t.timestamps
    end
  end
end
