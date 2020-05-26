class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_user, :require_same_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must log in first"
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = 'That is not yours to edit or delete!'
      redirect_to user_path(current_user)
    end
  end

end
