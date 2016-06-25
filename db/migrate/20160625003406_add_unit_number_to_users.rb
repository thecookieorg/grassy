class AddUnitNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unit_number, :string
  end
end
