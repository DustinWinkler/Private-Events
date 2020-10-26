class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to root_path, notice: "Success!"
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @user.invites.find_by(event_id: params[:event_id]).update(rsvp: params[:rsvp])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
