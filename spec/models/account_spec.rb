require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:account) { FactoryGirl.build(:account, user: user) }

  describe 'validations' do
    it { validate_uniqueness_of(:provider) }
    it { expect(account).to be_valid }
  end

  describe 'associations' do
    it { belong_to(:user) }
  end
end
