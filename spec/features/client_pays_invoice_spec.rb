require 'rails_helper'

feature 'Client pays invoice' do
  let :invoice { FactoryGirl.create(:invoice) }

  scenario 'by visiting payment page', js: true do
    visit new_invoice_subscription_path(invoice)
    expect(page).to have_content invoice.name
    client_email = Faker::Internet.email
    fill_in 'subscription[customer_email]', with: client_email
    within_frame('__privateStripeFrame3') do
      fill_in 'cardnumber', with: '4242 4242 4242 4242'
      fill_in 'exp-date', with:  '12/20'
      fill_in 'cvc', with: '123'
    end
    click_button 'COMPLETE PAYMENT'

    expect(page).to have_content 'THANK YOU!'
    subscription = Subscription.last
    expect(subscription.customer_email).to eq client_email
  end
end
