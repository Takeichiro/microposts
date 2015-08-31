class UsersController < ApplicationController
  before_action :set_users, only: [:show, :edit, :update, :destroy, :followings, :followers]

  def edit
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールは更新されました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Twitter clone App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def followings
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users.page(params[:page])
    render 'show_follow'   
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :location, :about, :password, :password_confirmation)
  end
  
  def set_users
    @user = User.find(params[:id])
  end
  
end