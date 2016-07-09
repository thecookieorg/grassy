class AddDescriptionOfCurrentMedicalNeedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description_of_current_medical_need, :string
  end
end
