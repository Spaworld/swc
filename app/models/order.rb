class Order < ActiveRecord::Base
  validates_presence_of :channel_id, :price_in_dollars, :placement_date, :legacy_id
  validates_uniqueness_of :legacy_id
  validates :channel_id,  with: :channel_id_validation
  validates :price_in_dollars, with: :price_validation

  def channel_id_validation
    unless ENV['SELECTED_CHANNELS'].include?(channel_id.to_s)
      errors[:base] << 'Order must belong to a known channel'
    end
  end

  def price_validation
    if price_in_dollars == 0
      errors[:base] << 'Total price must be greater than 0'
    end
  end
end
