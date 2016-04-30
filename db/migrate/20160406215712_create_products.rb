class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.integer :legacy_id
      t.jsonb   :skus, null: false, default: {}
      t.timestamps null: false
    end
    add_index :products, :legacy_id, unique: true
  end
end
