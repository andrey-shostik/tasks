require 'rails_helper'

describe 'Items', type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'add item' do
    visit new_item_path

    fill_in 'Title', with: 'My Title'
    fill_in 'Description', with: 'My Description'

    click_on('New item')

    expect(page).to have_content('My Title')
    expect(page).to have_content('My Description')
  end
end
