require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  subject { response }

  describe '#show' do
    before { get :show }

    it { expect(assigns(:users)).not_to be_nil }
    it { is_expected.to render_template('show') }
  end
end
