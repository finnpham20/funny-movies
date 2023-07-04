class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.create!(create_params)
    FetchVideoInfo.perform_async(post.id)
    flash[:success] = 'Your URL is added to share, please wait a moment to see your movie on newsfeed!'

    redirect_to root_path
  end

  private

  def create_params
    params.require(:post).permit(:youtube_url)
  end
end
