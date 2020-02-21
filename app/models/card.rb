class Card < ApplicationRecord
	#Association
	belongs_to :user, optional: true

	#Validation
	validates :customer_token, presence: true
end
