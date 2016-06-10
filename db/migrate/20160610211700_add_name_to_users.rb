class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :postal_code, :string
    add_column :users, :telephone, :string
    add_column :users, :date_of_birth, :datetime
    add_column :users, :is_female, :boolean, default: false
  end
end
