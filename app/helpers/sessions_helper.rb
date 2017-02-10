module SessionsHelper
  def current_user
    return nil if session[:users].nil?
    @current_user ||= User.find_by(id: session[:users]["id"])
  end
end
