class Cart < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items

  def sub_total
    sum = 0
    order_items.each do |order_items|
      sum += order_items.total_price
    end
    sum
  end
end
