class ApplicationController < ActionController::Base
   # helper_method :current_user

   private 

   # def authorize_user
   #   reject_user unless @user == current_user
   # end
 
   # def current_user
   #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
   # end
 
   def reject_user
     redirect_to root_path, alert: 'Доступ запрещён'
   end
end
