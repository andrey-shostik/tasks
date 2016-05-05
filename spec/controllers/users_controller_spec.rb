require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject { response }

  describe '#index' do
    before { get :index }

    it 'be success' do
      is_expected.to be_succes
      # is_expected.to have_http_status(200)
      # expect(response).to have_http_status(200)
    end

    it 'render template' do
      is_expected.to render_template('index')
      # expect(response).to render_template('index')
    end
  end

  describe '#new' do
    before { get :new }

    it 'be success' do
      is_expected.to be_succes
    end

    it { is_expected.to be_succes }

    it 'render template' do
      is_expected.to render_template('new')
    end

    it 'assign user' do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe '#create' do
    let(:user) { FactoryGirl.attributes_for(:user) }

    before { post :create, user: user }

    it 'be created' do
      expect(User.last.email).to eq('somemail@mail.com')
    end

    it 'be found' do
      is_expected.to have_http_status :redirect
    end

    it 'redirect_to user profile' do
      is_expected.to redirect_to(new_user_profile_path(User.last.id))
    end

    it 'has session' do
      expect(session[:current_user_id]).to be_eql(User.last.token)
    end
  end

  describe '#show' do
    let(:user) { FactoryGirl.create(:user) }

    before { get :show, id: user.id }

    it 'be success' do
      is_expected.to have_http_status(200)
    end

    it 'render template' do
      is_expected.to render_template('show')
    end
  end

  describe '#edit' do
    let(:user) { FactoryGirl.create(:user) }

    before { get :edit, id: user.id }

    it 'render template' do
      is_expected.to render_template('edit')
    end

    it 'be success' do
      is_expected.to be_succes
    end
  end

  describe '#update' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      put :update, id: user.id, user:
        { password: '222222', password_confirmation: '222222' }
      user.reload
    end

    it 'redirect_to user items' do
      is_expected.to redirect_to(user_path(user.id))
    end
  end
end
