class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def account_update_params
    params.require(:user).permit(:name, :email, :street_address, :unit_number, :buzzer_number, :city, :province, :postal_code, :telephone, :date_of_birth, :is_female, :password, :password_confirmation, :current_password)
    #params.require(:user).permit(:name, :email, :street_address, :unit_number, :buzzer_number, :city, :province, :postal_code, :telephone, :date_of_birth, :is_female, :password)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end



  #def update_resource(resource, account_update_params)
  #  resource.update_without_password(params)
  #end
end