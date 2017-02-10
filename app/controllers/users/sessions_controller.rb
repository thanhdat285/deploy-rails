class Users::SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:sign_in][:username]
    password = params[:sign_in][:password]
    @user = User.find_by(username: username)
    if @user.authenticate!(password)
      session[:users] = {
        "id" => @user.id
      }
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
