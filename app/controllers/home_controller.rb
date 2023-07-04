class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user).shared.order(updated_at: :desc).limit(100)
  end
end
