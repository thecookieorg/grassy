class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.string :image_1
      t.string :image_2
      t.string :image_3
      t.string :image_4

      t.timestamps null: false
    end
  end
end
