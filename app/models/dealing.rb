class Dealing < ApplicationRecord
    # Association
	belongs_to :user, class_name: 'User', foreign_key: 'buyer_id'
	belongs_to :item
end
