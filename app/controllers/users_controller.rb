class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :load_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update]

  def index
    @users = User.all
    prepare_viewed_users
  end

  def show
    @new_question = @user.questions.build
    @tags = @user.questions.joins(:tags).distinct.pluck(:title)

    prepare_viewed_users true
  end

  def edit
  end

  def update
    if @user.update(update_user_params)
      flash[:success] = "#{@user.name}, ваш профиль изменён!"
      redirect_to action: 'show'
    else
      render 'edit'
    end
  end

  private

  def prepare_viewed_users(need_to_add=false)
    viewed_pages_service = PublicUsers::ViewedUsers.new(session)
    viewed_pages_service.add_page(current_user, @user) if need_to_add
    @last_viewed_users = viewed_pages_service.get_viewed_users
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def set_current_user
    @user = current_user
  end

  def update_user_params
    params.require(:user).permit(:name, :avatar_url)
  end

  def user_params
    params.require(:user).permit(:email, :password, :username, :name, :password_confirmation)
  end

end
