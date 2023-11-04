module PublicUsers
  class ViewedUsers < ApplicationController
    def initialize(session)
      @session = session
    end

    def add_page(current_user, user)
      last_viewed_users_ids = @session[:viewed_users] || []

      unless current_user.present? && current_user == @user
        last_viewed_users_ids.delete(user.id) if last_viewed_users_ids.include?(user.id)
        last_viewed_users_ids << user.id
        last_viewed_users_ids.shift if last_viewed_users_ids.length > 3
      end

      @session[:viewed_users] = last_viewed_users_ids

      @last_viewed_users = User.find(last_viewed_users_ids.reverse)
    end

    def get_viewed_users
      User.find(@session[:viewed_users] || []).reverse
    end
  end
end