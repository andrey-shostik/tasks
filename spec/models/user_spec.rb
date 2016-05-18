require 'rails_helper'

RSpec.describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { FactoryGirl.build(:profile, user: user) }
  let(:item) { FactoryGirl.build(:item, user: user) }
  let(:account) { FactoryGirl.build(:account, user: user) }

  describe 'validations' do
    it { have_secure_token }
    it { have_secure_password }
    it { validate_presence_of(:email) }
    it { validate_length_of(:email) }
    it { validate_uniqueness_of(:email) }

    it { expect(user).to be_valid }
  end

  describe 'associations' do
    it { have_many(:items) }
    it { have_many(:accounts) }
    it { have_one(:profile) }
  end
end
