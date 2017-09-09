require 'rails_helper'

feature 'vendor registers for site' do
  scenario 'vendor registers' do
    visit root_path
    click_link "Sign up"
    expect(page).to have_text('Begin accepting payments')
    fill_in_registration_fields
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  def fill_in_registration_fields
    fill_in 'vendor[email]', with: Faker::Internet.email
    fill_in 'vendor[password]', with: Devise.friendly_token.first(8)
    click_button 'TRY IT NOW'
  end
end
