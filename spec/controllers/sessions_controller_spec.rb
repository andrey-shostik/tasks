require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe '#create' do
    let(:user) { FactoryGirl.attributes_for(:user) }

    before { post :create }

    it { is_expected.to have_http_status(302) }
  end
end
