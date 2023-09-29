# frozen_string_literal: true

module Posts
  class CreateService
    def initialize(user, params)
      @user = user
      @params = params
    end

    def execute
      post = user.posts.create!(params)
      FetchVideoInfo.perform_async(post.id)
    end

    private

    attr_reader :user, :params
  end
end
