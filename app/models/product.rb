class Product < ActiveRecord::Base
  validates_presence_of :name, :legacy_id
  has_many :orders, through: :order_details
end
