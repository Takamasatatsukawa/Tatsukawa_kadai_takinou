class UsersController < ApplicationController
  before_action :correct_user, only: [:show]
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.registration_confirmation(@user).deliver_later
      redirect_to @user, notice: 'ユーザー登録が完了しました。'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user && current_user != @user
      redirect_to current_user
    elsif !current_user
      redirect_to login_path, notice: 'ログインが必要です。'
    end
  end
end
