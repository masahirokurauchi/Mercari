class Addresse < ApplicationRecord

	#Association
	belongs_to :user

	#Validation
	validates :prefecture, :city, :house_number, presence: true
	validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
	validates :phone_number, numericality: { only_integer: true}
end
