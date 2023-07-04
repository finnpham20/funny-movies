require 'rails_helper'

RSpec.describe FetchVideoInfo do
  let(:post) { create(:post) }

  describe '#perform' do
    it 'performs a job' do
      described_class.perform_async(post.id)
      expect(described_class).to have_enqueued_sidekiq_job(post.id)
    end
  end
end
