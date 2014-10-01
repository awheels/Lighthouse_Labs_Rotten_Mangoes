class Admin::UsersController < ApplicationController

  def index
    puts "admin greeting"
    @users = User.all.page(params[:page]).per(10)
  end

  def new 
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    puts "admin hello"
    if @user.save
      redirect_to admin_users_path, notice: "You've created a new user named #{@user.firstname}!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "You've updated user #{@user.firstname}!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :is_admin, :password, :password_confirmation)
  end

end
