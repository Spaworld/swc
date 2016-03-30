class Order < ActiveRecord::Base
  validates_presence_of :channel_id, :total_price, :placement_date, :legacy_id
  validates :channel_id,  with: :channel_id_validation
  validates :total_price, with: :total_price_validation

  def channel_id_validation
    unless ENV['SELECTED_CHANNELS'].include?(channel_id.to_s)
      errors[:base] << 'Order must belong to a known channel'
    end
  end

  def total_price_validation
    if total_price == 0
      errors[:base] << 'Total price must be greater than 0'
    end
  end
end
