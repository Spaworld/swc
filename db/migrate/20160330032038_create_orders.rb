class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer   :channel_id
      t.float     :total_price
      t.datetime  :placement_date
      t.integer   :legacy_id
      t.timestamps null: false
    end
  end
end
