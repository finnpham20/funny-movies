# frozen_string_literal: true

require 'google/apis/youtube_v3'

class YoutubeService
  def initialize
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = Rails.application.credentials.dig(:youtube, :api_key)
  end

  def fetch_info(video_id)
    result = {}
    return result if video_id.blank?

    response = youtube.list_videos('snippet', id: video_id)
    if response.items.size.positive?
      result[:title] = response.items[0].snippet.title
      result[:description] = response.items[0].snippet.description
    end

    result
  rescue StandardError => e
    Rails.logger.error e
    # raise to Sentry or Rollbar here
  end

  private

  attr_reader :youtube
end
