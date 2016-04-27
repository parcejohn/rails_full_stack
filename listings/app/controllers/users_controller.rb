class UsersController < ApplicationController
  
  before_action :logged_in
  before_action :checkAuth # local private method

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render "new"  
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    User.destroy(user)
    redirect_to users_path

  end

  private
  def checkAuth
    is_authorized('Admin')
  end
  def user_params
    params.require(:user).permit(:user_id, :firstname, :lastname, :email, :usertype, :password)      
  end 
end