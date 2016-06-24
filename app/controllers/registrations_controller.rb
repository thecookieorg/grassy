class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :city, :province, :postal_code, :telephone, :date_of_birth, :is_female, :password, :password_confirmation, :current_password)
  end
end