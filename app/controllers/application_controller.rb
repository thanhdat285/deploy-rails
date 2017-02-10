class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login_required
    redirect_to root_path unless session[:users]
  end
end
