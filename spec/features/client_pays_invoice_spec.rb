require 'rails_helper'

feature 'Client pays invoice' do
  let :invoice { FactoryGirl.create(:invoice) }

  scenario 'by visiting payment page', js: true do
    visit new_invoice_subscription_path(invoice)
    expect(page).to have_content invoice.name
    expect(page).to have_content 'Test Stripe Account'
    expect(page).to have_content 'DBA RIKER INC.'
    expect(page).to have_content '$1,000.00'
    expect(page).to have_content invoice.description

    client_email = Faker::Internet.email
    fill_in 'subscription[customer_email]', with: client_email
    within_frame('__privateStripeFrame3') do
      fill_in 'cardnumber', with: '4242 4242 4242 4242'
      fill_in 'exp-date', with: '12/20'
      fill_in 'cvc', with: '123'
    end
    click_button 'PLACE ORDER NOW'

    expect(page).to have_content 'THANK YOU!'
    expect(Subscription.count).to eq 1
    subscription = Subscription.last
    expect(subscription).to have_attributes(
      customer_email: client_email,
      id_for_subscription: a_string_starting_with('sub'),
      id_for_customer: a_string_starting_with('cus')
    )

    # delete test data
    # sub = Stripe::Subscription.retrieve(subscription.id_for_subscription)
    # sub.delete
    cu = Stripe::Customer.retrieve(subscription.id_for_customer)
    cu.delete
  end
end
