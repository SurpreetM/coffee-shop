class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text :name
      t.text :description
      t.integer :price
      t.integer :points 
      t.integer :category_id

      t.timestamps
    end
  end
end
