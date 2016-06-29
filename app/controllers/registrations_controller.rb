class RegistrationsController < Devise::RegistrationsController

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @user = User.find(current_user.id)

    if needs_password?
      successfully_updated = @user.update_with_password(account_update_params)
    else
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
      account_update_params.delete('current_password')
      successfully_updated = @user.update_attributes(account_update_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to edit_user_registration_path
    else
      render 'edit'
    end
  end


  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def needs_password?
    @user.email != params[:user][:email] || params[:user][:password].present?
  end

  #def account_update_params
  #  params.require(:user).permit(:name, :email, :street_address, :unit_number, :buzzer_number, :city, :province, :postal_code, :telephone, :date_of_birth, :is_female, :password, :password_confirmation, :current_password, :latitude, :longitude)
  #end



  #def update_resource(resource, account_update_params)
  #  resource.update_without_password(params)
  #end
end