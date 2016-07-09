class AddUserIdToStaticimages < ActiveRecord::Migration
  def change
    add_reference :staticimages, :user, index: true, foreign_key: true
  end
end
