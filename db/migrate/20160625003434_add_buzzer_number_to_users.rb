class AddBuzzerNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :buzzer_number, :string
  end
end
