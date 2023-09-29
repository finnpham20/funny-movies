require 'rails_helper'

RSpec.describe Posts::CreateService, type: :service do
  let(:user) { create(:user) }
  let(:create_params) do
    {
      youtube_url: 'https://www.youtube.com/watch?v=X1EJjaoJtIY'
    }
  end
  let(:service) { described_class.new(user, create_params) }

  describe '#execute' do
    context 'when add correct url' do
      it 'created new post' do
        expect { service.execute }.to change(Post, :count).by(1)
      end

      it 'add new job fetch video info' do
        service.execute

        expect(FetchVideoInfo).to have_enqueued_sidekiq_job(Post.last.id)
      end
    end

    context 'when add invalid url to share' do
      let(:create_params) { { youtube_url: 'https://www.youtube.com/watch/haha' } }

      it 'raise error record invalid' do
        expect { service.execute }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Youtube url is not in the correct format., Video can't be blank")
      end
    end
  end
end
