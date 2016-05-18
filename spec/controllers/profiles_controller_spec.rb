require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  before { session[:current_user_id] = user.token }

  subject { response }

  describe '#new' do
    before do
      get :new, user_id: user.id
    end

    it { is_expected.to render_template('new') }

    it { is_expected.to be_succes }
  end

  describe '#create' do
    let(:profile_params) { FactoryGirl.attributes_for(:profile) }

    context 'valid data' do
      before { post :create, user_id: user.id, profile: profile_params }

      it { expect(User.last.profile.username).to eq('andrey_9828') }
      it { is_expected.to redirect_to user_profile_path }
      it { is_expected.to have_http_status('302') }
    end

    context 'invalid data' do
      before do
        post :create, user_id: user.id, profile:
          {
            username: 'andrey_9828',
            first_name: nil,
            last_name: 'Shostik'
          }
      end
      it { is_expected.to render_template('new') }
    end
  end

  describe '#show' do
    before { get :show, user_id: user.id }

    it { is_expected.to be_succes }
    it { is_expected.to render_template('show') }
  end

  describe '#edit' do
    before { get :edit, user_id: user.id }

    it { is_expected.to be_succes }
    it { is_expected.to render_template('edit') }
  end

  describe '#update' do
    let!(:profile) { FactoryGirl.create(:profile, user_id: user.id) }

    context 'valid data' do
      before do
        patch :update, user_id: user.id, profile: { username: 'andrew_9828' }
        user.reload
      end

      it { expect(Profile.last.username).to eq('andrew_9828') }
      it { is_expected.to redirect_to user_profile_path }
    end

    context 'invalid data' do
      before do
        patch :update, user_id: user, profile: { first_name: nil }
        user.reload
      end
      it { is_expected.to render_template('edit') }
    end
  end
end
