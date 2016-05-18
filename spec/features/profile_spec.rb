require 'rails_helper'

describe 'Profiles', type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'new profile' do
    visit new_user_profile_path(user.id)

    fill_in 'Username', with: 'andrey_9828'
    fill_in 'First name', with: 'Andrey'
    fill_in 'Last name', with: 'Shostik'

    click_on('Save profile')

    expect(page).to have_content('andrey_9828')
    expect(page).to have_content('Andrey')
    expect(page).to have_content('Shostik')
  end
end
