class Users::SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:sign_in][:username]
    password = params[:sign_in][:password]
    @user = User.find_by(username: username)
    if @user.nil?
      flash[:error] = "Account does not exist"
      return redirect_to users_sign_in_path
    end
    if @user.authenticate!(password)
      sign_in @user
      flash[:success] = "Signed in"
    else
      flash[:error] = "Invalid username or password"
    end
    redirect_to root_path
  end

  def delete
    session[:users] = nil
    redirect_to root_path
  end
end
