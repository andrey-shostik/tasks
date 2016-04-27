require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe '#index' do

  end

  describe '#new' do

  end

  describe '#create' do

  end

  describe '#show' do

  end

  describe '#edit' do

  end

  describe '#destroy' do

  end

  describe '#complete' do

  end

end



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
