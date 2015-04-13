class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "USer"

  validates :address, :city, :state, presence: true
end
