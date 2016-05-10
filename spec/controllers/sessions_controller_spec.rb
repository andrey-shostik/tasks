require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  subject { response }

  describe '#new' do
    before { get :new }

    it { is_expected.to render_template('new') }
  end

  describe '#create' do
    let!(:user) { FactoryGirl.create(:user) }

    context 'valid data' do
      let(:user_params) { FactoryGirl.attributes_for(:user) }

      before { post :create, user: user_params }

      it { expect(session[:current_user_id]).to eq(user.token) }
      it { is_expected.to redirect_to root_path }
    end

    context 'invalid data' do
      before { post :create, user: { email: 'invalid', password: 'invalid' } }

      it { is_expected.to render_template('new') }
    end
  end

  describe '#destroy' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      session[:current_user_id] = user.token
      delete :destroy, id: user.id
    end

    it { expect(session[:current_user_id]).to be_nil }

    it { is_expected.to redirect_to root_path }
  end
end
