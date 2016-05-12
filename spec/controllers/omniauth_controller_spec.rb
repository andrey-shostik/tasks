require 'rails_helper'

RSpec.describe OmniauthController, type: :controller do
  subject { response }

  describe '#create' do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    context 'have user' do
      let!(:user) { FactoryGirl.create(:user) }
      let(:account) { assigns(:account) }

      before { post :create, provider: :google_oauth2 }

      it { expect(account.user_id).to eq(user.id) }
      it { expect(session[:current_user_id]).not_to be nil }
      it { is_expected.to redirect_to root_path }
    end

    context 'have not user' do
      before { post :create, provider: :google_oauth2 }

      it { expect(assigns(:user)).to be_valid }
      it { expect(assigns(:profile)).to be_valid }
      it { expect(session[:current_user_id]).not_to be nil }
      it { is_expected.to redirect_to(edit_user_path(assigns(:user))) }
    end
  end
end
