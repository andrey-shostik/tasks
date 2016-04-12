require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  subject { response }

  describe "#new" do
    before { get :new }

    it { is_expected.to have_http_status(302) }
  end

  describe "#create" do
    let(:item) { FactoryGirl.attributes_for(:item) }

    before { post :create, item: item }

    it { is_expected.to have_http_status :redirect }
  end
end
