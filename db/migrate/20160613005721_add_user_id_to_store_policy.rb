class AddUserIdToStorePolicy < ActiveRecord::Migration
  def change
    add_reference :store_policies, :user, index: true, foreign_key: true
  end
end
