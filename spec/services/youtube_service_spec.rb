require 'rails_helper'

RSpec.describe YoutubeService, type: :service do
  let(:youtube_service) { described_class.new }

  describe '#fetch_info' do
    it 'returns the title and description of a YouTube video' do
      video_id = 'b8u2GPYFeSA'

      result = youtube_service.fetch_info(video_id)

      expect(result).to be_a(Hash)
      expect(result[:title]).not_to be_empty
      expect(result[:description]).not_to be_empty
    end

    it 'returns empty hash when video_id not true' do
      video_id = '123xxx'

      result = youtube_service.fetch_info(video_id)

      expect(result).to be_a(Hash)
      expect(result.empty?).to be true
    end

    it 'returns empty hash when video_id is empty' do
      result = youtube_service.fetch_info(nil)

      expect(result.empty?).to be true
    end
  end
end
