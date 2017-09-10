require 'rails_helper'

feature 'vendor onboards for site' do
  scenario 'by registering' do
    visit root_path
    click_link "Sign up"
    expect(page).to have_text('Begin accepting payments')
    fill_in_registration_fields
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'by connecting with Stripe' do
    visit root_path
    click_link "Sign up"
    expect(page).to have_text('Begin accepting payments')
    fill_in_registration_fields
    expect(page).to have_content('Welcome! You have signed up successfully.')
    click_link 'CONNECT TO STRIPE'
    expect(page).to have_content 'Congrats on connecting your Stripe account!'
    vendor = Vendor.last
    expect(vendor.stripe_user_id).not_to eq nil
    expect(page).to have_link('CREATE A PAYMENT LINK', href: new_invoice_path)
  end

  def fill_in_registration_fields
    fill_in 'vendor[email]', with: Faker::Internet.email
    fill_in 'vendor[password]', with: Devise.friendly_token.first(8)
    click_button 'TRY IT NOW'
  end
end
