# frozen_string_literal: true

class PostChannel < ApplicationCable::Channel
  def subscribed
    return reject unless current_user

    stream_for 'post_channel'
  end

  def unsubscribed
    return reject unless current_user

    stop_stream_for current_user
  end
end
