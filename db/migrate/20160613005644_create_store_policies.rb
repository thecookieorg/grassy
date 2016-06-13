class CreateStorePolicies < ActiveRecord::Migration
  def change
    create_table :store_policies do |t|
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
