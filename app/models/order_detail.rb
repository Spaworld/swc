class OrderDetail < ActiveRecord::Base
  validates_presence_of :order_id, :product_id, :quantity
  validates :quantity, with: :quantity_validation
  belongs_to :order
  belongs_to :product

  def quantity_validation
    errors[:base] << 'Quantity must be greater than 0' if quantity == 0
  end
end
