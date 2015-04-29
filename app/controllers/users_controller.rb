class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    # render :json => @user

    if @user['id'].nil?
      flash[:danger] = "Error trying to create new login"
      render :new
    else
      flash[:success] = "Account Creation Successful!"
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,:password,:name)
  end

end
