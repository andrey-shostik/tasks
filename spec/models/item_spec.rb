require 'rails_helper'

RSpec.describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.build(:item, user: user) }

  describe 'validations' do
    it { validate_presence_of(:title) }
    it { validate_presence_of(:description) }
    it { expect(item).to be_valid }
  end

  describe 'associations' do
    it { belong_to(:user) }
  end
end
