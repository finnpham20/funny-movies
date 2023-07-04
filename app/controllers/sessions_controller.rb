class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      if @user.authenticate(user_params[:password])
        cookies.signed[:user_id] = @user.id
        flash[:success] = 'Login successful!'
      else
        flash[:error] = 'Email or Password incorrect!'
      end
    else
      create_user
    end
    redirect_to root_path
  end

  def destroy
    cookies.signed[:user_id] = nil
    flash[:success] = 'Logout successful!'
    redirect_to root_path
  end

  private

  def user_params
    params.require([:email, :password])
    params.permit(:email, :password)
  end

  def create_user
    @user = User.new(user_params)
    if @user.save!
      flash[:success] = 'Register successful! Please login to continue'
    end
  end
end
