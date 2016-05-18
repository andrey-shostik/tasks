require 'rails_helper'

describe 'Sessions', type: :feature do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'User auntheticate' do
    visit new_session_path

    fill_in 'Email', with: 'somemail@mail.com'
    fill_in 'Password', with: '111111'

    click_button('Sign in')

    expect(page).to have_content('My to do list')
  end
end
