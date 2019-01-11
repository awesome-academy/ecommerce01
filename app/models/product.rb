class Product < ApplicationRecord
  belongs_to :categorie
  has_many :order_items, dependent: :destroy
  has_many :comment_raitings, dependent: :destroy
  has_many :orders, through: :order_items

  def self.search search
    where("name LIKE ?", "%#{search}%")
  end
end
