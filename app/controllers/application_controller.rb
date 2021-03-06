class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin?
    current_user.is_admin == True
  end

  def ghost_user
    @ghost_user ||= User.find(session[:ghost_user_id]) if session[:ghost_user_id]
  end

  helper_method :current_user, :ghost_user


end
