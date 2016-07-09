class AddSlideshowToSlideshows < ActiveRecord::Migration
  def change
    add_column :slideshows, :slideshow, :string
  end
end
