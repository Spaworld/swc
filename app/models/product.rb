class Product < ActiveRecord::Base
  validates_presence_of :name, :price_in_dollars, :legacy_id
end
