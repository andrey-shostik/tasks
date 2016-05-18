require 'rails_helper'

describe 'Users', type: :feature do
  scenario 'User registration' do
    visit new_user_path

    fill_in 'Email', with: 'somemail@mail.com'
    fill_in 'Password', with: '111111'
    fill_in 'Confirm password', with: '111111'

    click_on('New User')

    expect(page).to have_content('Username')
    expect(page).to have_content('First name')
    expect(page).to have_content('Last name')
  end
end
