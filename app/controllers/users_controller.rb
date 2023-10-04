class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]

  def index
    @users = User.all
  end

  def show
    @new_question = @user.questions.build
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    
    @user = User.new
  end

  def create 
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      flash[:success] = "#{@user.name}, ваш аккаунт успешно создан!"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
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

  def update_user_params
    params.require(:user).permit(:name, :avatar_url)
  end

  def user_params
    params.require(:user).permit(:email, :password, :username, :name, :password_confirmation)
  end

end
