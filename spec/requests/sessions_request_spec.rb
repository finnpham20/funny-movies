require 'rails_helper'

RSpec.describe 'Sessions' do
  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid credentials' do
      it 'redirects to the home page' do
        post '/login', params: { email: user.email, password: user.password }

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('session.login.success'))
      end

      it 'sets the user id in the cookies' do
        post '/login', params: { email: user.email, password: user.password }

        expect(ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash).signed[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      it 'renders the login page' do
        post '/login', params: { email: user.email, password: 'wrongpassword' }

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('session.login.incorrect'))
      end

      it 'does not set the user id in the cookies' do
        post '/login', params: { email: user.email, password: 'wrongpassword' }

        expect(ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash).signed[:user_id]).to be_nil
      end
    end

    context 'with new user email' do
      let(:user_new) { build(:user) }

      it 'create new user and request to login' do
        post '/login', params: { email: user_new.email, password: user_new.password }

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('session.sign_up.success'))
      end

      it 'create new user and wrong format password' do
        post '/login', params: { email: user_new.email, password: 'abc123456' }

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('errors.models.user.password_format'))
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    before do
      login_with(user)
    end

    it 'clears the user id from the cookies' do
      delete '/logout'

      expect(ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash).signed[:user_id]).to be_nil
    end

    it 'redirects to the home page' do
      delete '/logout'

      expect(response).to redirect_to(root_path)
    end
  end
end
