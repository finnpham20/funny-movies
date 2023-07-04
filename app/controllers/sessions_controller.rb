# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      if @user.authenticate(user_params[:password])
        cookies.signed[:user_id] = @user.id
        flash[:success] = I18n.t(:'session.login.success')
      else
        flash[:error] = I18n.t(:'session.login.incorrect')
      end
    else
      create_user
    end
    redirect_to root_path
  end

  def destroy
    cookies.signed[:user_id] = nil
    flash[:success] = I18n.t(:'session.logout.success')
    redirect_to root_path
  end

  private

  def user_params
    params.require(%i[email password])
    params.permit(:email, :password)
  end

  def create_user
    @user = User.new(user_params)
    return unless @user.save!

    flash.now[:success] = I18n.t(:'session.sign_up.success')
  end
end
