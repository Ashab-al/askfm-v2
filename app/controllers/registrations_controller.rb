class RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:edit, :update]
  
  protected

  def update_resource(resource, account_update_params)
    resource.update_without_password(account_update_params)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, except: [:current_password, :password])
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :username, :avatar_url)
  end
  
end