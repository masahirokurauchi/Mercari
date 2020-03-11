class Dealing < ApplicationRecord
    # Association
	belongs_to :user, class_name: 'User', foreign_key: 'buyer_id'
	belongs_to :item, class_name: 'Item', foreign_key: 'item_id'
end