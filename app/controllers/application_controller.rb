class ApplicationController < ActionController::Base
  include Pundit::Authorization

  after_action :verify_authorized, except: [:index, :show]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :user_can_destroy_question?

  def change_language
    I18n.locale = params[:locale]
    redirect_back fallback_location: root_path, notice: "Язык успешно изменён"
  end

  private

  def user_can_destroy_question?(question) 
    user_signed_in? && current_user == question.user 
  end

  def user_not_authorized
    flash[:alert] = 'Вам нет доступа к этому действию'
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar_url], except: [:password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in,        keys: [:login, :password])
  end
end
