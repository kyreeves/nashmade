class Product < ActiveRecord::Base
  searchkick
  belongs_to :user
  belongs_to :category
  has_many :orders, dependent: :destroy

  has_attached_file :image,
                    styles: { large: "500x500", medium: "300x300", thumb: "150x150" },
                    default_url: "default.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :category, presence: true
end
