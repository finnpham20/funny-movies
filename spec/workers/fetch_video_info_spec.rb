require 'rails_helper'

RSpec.describe FetchVideoInfo do
  let(:post) { create(:post) }

  describe 'perform' do
    it 'have a job' do
      described_class.perform_async(post.id)
      expect(described_class).to have_enqueued_sidekiq_job(post.id)
    end

    it 'execute a job' do
      fetch_info_double = double
      allow(fetch_info_double).to receive(:fetch_info).and_return({title: 'title', description: 'description'})
      allow(YoutubeService).to receive(:new).and_return(fetch_info_double)
      described_class.new.perform(post.id)

      expect(post.reload.title).not_to be_nil
      expect(post.reload.description).not_to be_nil
    end

    it 'return when post empty' do
      Post.destroy(post.id)
      described_class.new.perform(post.id)
      expect { post.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'can not get title' do
      fetch_info_double = double
      allow(fetch_info_double).to receive(:fetch_info).and_return({})
      allow(YoutubeService).to receive(:new).and_return(fetch_info_double)
      described_class.new.perform(post.id)

      expect(post.reload.status).to eq('unshared')
    end
  end
end
