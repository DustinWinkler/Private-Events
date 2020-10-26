class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(name: params[:name])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_path, notice: "There is no user by that name."
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
