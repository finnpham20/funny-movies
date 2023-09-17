# frozen_string_literal: true

require 'google/apis/youtube_v3'

class FetchVideoInfo
  include Sidekiq::Worker
  queue_as SideKiqQueue::FETCH_VIDEO_INFO

  def perform(post_id)
    post = Post.find_by(id: post_id)
    return if post.blank? || post.shared?

    ActiveRecord::Base.transaction do
      result = YoutubeService.new.fetch_info(post.video_id)

      if result.empty? || !(result.key?(:title) && result.key?(:description))
        post.update!(status: :unshared)
      else
        result.merge!(status: :shared)
        post.update!(result)

        msg = post.slice(:id, :title, :video_id, :description)
        msg.merge!(email: post.user.email)
        PostChannel.broadcast_to('post_channel', msg.to_json)
      end
    end
  end
end
