require 'rails_helper'

RSpec.describe 'Posts' do
  let(:user) { create(:user) }

  before do
    login_with(user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get '/posts/new'

      expect(response).to render_template(:new)
    end

    it 'assigns a new post to @post' do
      get '/posts/new'

      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new post' do
        expect do
          post '/posts', params: { post: attributes_for(:post) }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the home page' do
        post '/posts', params: { post: attributes_for(:post) }

        expect(response).to redirect_to(root_path)
      end

      it 'new post with pending status' do
        post '/posts', params: { post: attributes_for(:post) }

        expect(Post.last.status).to eq 'pending'
      end

      it 'enqueues a worker FetchVideoInfo to process the new post' do
        post '/posts', params: { post: attributes_for(:post) }

        expect(FetchVideoInfo).to have_enqueued_sidekiq_job(Post.last.id)
      end
    end
  end

  context 'with invalid attributes' do
    it 'does not create a new post' do
      expect do
        post '/posts', params: { post: { youtube_url: nil } }
      end.not_to change(Post, :count)
    end
  end
end
