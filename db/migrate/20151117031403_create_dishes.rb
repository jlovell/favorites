class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.references :category, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
db/migrate/20151117031403_create_dishes.rb
