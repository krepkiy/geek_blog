class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :show_banner

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to root_path unless current_user || controller_name == 'sessions'
  end

  def show_banner
    count_views % 10 == 0
  end

  private

  def count_views
    cookies[:views] = if cookies[:views].present?
      cookies[:views].to_i + 1;
    else
      1;
    end
  end

end
