class AddUserIdToSlideshows < ActiveRecord::Migration
  def change
    add_reference :slideshows, :user, index: true, foreign_key: true
  end
end
