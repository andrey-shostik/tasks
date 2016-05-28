require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }

  subject { response }

  describe '#index' do
    before { get :index }

    it { is_expected.to render_template(layout: 'admin/application') }
    it { is_expected.to be_succes }
  end

  describe '#destroy' do
    let!(:user1) { FactoryGirl.create(:user, email: 'new_email@rambler.ru') }
    before { xhr :delete, :destroy, id: user.id }

    it { is_expected.to have_http_status('200') }
  end
end
