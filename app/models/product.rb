class Product < ActiveRecord::Base
  validates_presence_of :name, :legacy_id
end
