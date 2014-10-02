class Admin::GhostsController < ApplicationController
  def new
  end

  def create
    session[:saved_admin] = session[:user_id]
    session[:user_id] = params[:user_id]
    redirect_to movies_path
  end

  def destroy
    session[:user_id] = session[:saved_admin]
    session[:saved_admin] = nil
    redirect_to movies_path
  end

end
