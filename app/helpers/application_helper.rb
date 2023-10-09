module ApplicationHelper
  def user_avatar(user)
    return user.avatar_url if user.avatar_url.present?
    asset_path 'avatar.png'
  end
end
