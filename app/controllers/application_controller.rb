# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorsHandler

  layout 'funny_movies/_main'
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
  helper_method :current_user

  def authenticate_user!
    raise Unauthorized unless current_user
  end

  def render_404
    flash[:error] = I18n.t('page.not_found')

    redirect_to root_path
  end
end
