class ApplicationController < ActionController::Base

   private 

   def reject_user
     redirect_to root_path, alert: 'Доступ запрещён'
   end
end
