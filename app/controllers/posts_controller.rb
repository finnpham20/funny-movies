# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    Posts::CreateService.new(current_user, create_params).execute
    flash[:success] = I18n.t('post.create.success')

    redirect_to root_path
  end

  private

  def create_params
    params.require(:post).permit(:youtube_url)
  end
end
