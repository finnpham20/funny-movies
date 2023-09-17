require 'rails_helper'

RSpec.describe 'Homes' do
  describe 'GET #index' do
    it 'renders the index template' do
      get '/'
      expect(response).to render_template(:index)
    end

    it 'assigns all posts to @posts' do
      10.times do
        create(:post, status: :shared, video_id: SecureRandom.hex(5), title: Faker::Movie.title,
                      description: Faker::Lorem.sentence(word_count: 100))
      end

      get '/'
      expect(assigns(:posts).size).to eq(10)
    end
  end

  describe 'not found page' do
    it 'renders homepage when go to undefined_page' do
      get '/undefined_page'

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include(I18n.t('page.not_found'))
    end
  end
end
