class Product < ActiveRecord::Base
  searchkick
  belongs_to :user
  has_many :orders

  has_attached_file :image, styles: { :medium => "200x200", :thumb => "150x150>" }, default_url: "default.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
