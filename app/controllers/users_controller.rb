class UsersController < ApplicationController
  def new
    puts "greetings"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts "hi"
    if @user.save
      session[:user_id] = @user.id 
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :is_admin, :password, :password_confirmation)
  end
end
