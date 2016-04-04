class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer   :channel_id
      t.float     :price_in_dollars
      t.datetime  :placement_date
      t.integer   :legacy_id
      t.timestamps null: false
    end
    add_index :orders, :legacy_id, unique: true
  end
end
