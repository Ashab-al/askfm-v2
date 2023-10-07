class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :user_can_destroy_question?

  private

  def user_can_destroy_question?(question) 
    user_signed_in? && current_user == question.user 
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
