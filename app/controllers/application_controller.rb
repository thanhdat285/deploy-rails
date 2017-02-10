class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login_required
    redirect_to root_path unless session[:users]
  end

  def current_user
    return nil if session[:users].nil?
    @current_user ||= User.find_by(id: session[:users]["id"])
  end
end
