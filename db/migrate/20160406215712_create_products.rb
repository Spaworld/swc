class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.integer :legacy_id
      t.jsonb   :skus, null: false, default: {}
      t.timestamps null: false
    end
  end
end
