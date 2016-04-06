class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :city
      t.string :state
      t.string :zip
      t.references :restaurant, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
