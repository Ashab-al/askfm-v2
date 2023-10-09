class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :load_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @new_question = @user.questions.build
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
