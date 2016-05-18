require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  before { session[:current_user_id] = user.token }

  describe '#new' do
    subject { response }

    before { get :new }

    it { expect(assigns(:item).user_id).to eq(user.id) }
    it { expect(assigns(:item)).to be_a_new(Item) }
    it { is_expected.to have_http_status :ok }
    it { is_expected.to render_template('new') }
  end

  describe '#create' do
    context 'valid data' do
      let(:item) { FactoryGirl.attributes_for(:item) }
      before { post :create, item: item, user_id: user.id }

      it { expect(user.items.first.title).to eq('title') }
      it { is_expected.to redirect_to user_path(user.id) }
    end

    context 'invalid data' do
      before { post :create, item: { title: nil, description: nil } }
      it { is_expected.to render_template('new') }
    end
  end

  describe '#show' do
    let!(:item) { FactoryGirl.create(:item, user_id: user.id) }

    before { get :show, id: item.id }

    it { expect(assigns(:item).title).to eq('title') }
    it { is_expected.to render_template('show') }
  end

  describe '#edit' do
    let!(:item) { FactoryGirl.create(:item, user_id: user.id) }

    before { get :edit, id: item.id }

    it { expect(assigns(:item).title).to eq('title') }
    it { is_expected.to render_template('edit') }
  end

  describe '#update' do
    let!(:item) { FactoryGirl.create(:item, user_id: user.id) }

    context 'valid data' do
      before do
        put :update, id: item.id, item: { title: 'new title' }
        item.reload
      end

      it { expect(assigns(:item).title).to eq('new title') }
      it { is_expected.to redirect_to item_path(user.id) }
    end

    context 'invalid data' do
      before do
        put :update, id: item.id, item: { title: nil }
        item.reload
      end

      it { is_expected.to render_template('edit') }
    end
  end

  describe '#destroy' do
    let!(:item) { FactoryGirl.create(:item, user_id: user.id) }
    before { delete :destroy, id: item.id }

    it { is_expected.to redirect_to root_path }
  end

  describe '#complete' do
    let!(:item) { FactoryGirl.create(:item, user_id: user.id) }
    let!(:time) { Time.now }

    before { patch :complete, id: item.id, item: { completed_at: time } }

    it { expect(assigns(:item).completed_at).not_to be_nil }
    it { is_expected.to redirect_to root_path }
  end
end
