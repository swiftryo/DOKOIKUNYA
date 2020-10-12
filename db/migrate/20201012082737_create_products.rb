class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.string :image_id
      t.boolean :status
      t.integer :prefecture_code
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
