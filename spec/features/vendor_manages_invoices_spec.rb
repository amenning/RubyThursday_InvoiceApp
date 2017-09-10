require 'rails_helper'

feature 'Vendor manages invoices' do
  let :vendor { FactoryGirl.create(:vendor_with_stripe_acct) }

  before do
    login_as(vendor, scope: :vendor)
  end

  scenario 'by creating new invoice' do
    visit new_invoice_path
    expect(page).to have_content 'New Invoice'
    fill_in 'invoice[name]', with: 'Awesome invoice'
    fill_in 'invoice[description]', with: Faker::Lorem.paragraph
    fill_in 'invoice[amount]', with: '1000'
    click_button 'CREATE INVOICE'

    expect(Invoice.count).to eq 1
    expect(page).to have_content 'Invoice successfully created!'
    expect(page).to have_content 'INVOICES'

    invoice = Invoice.last
    expect(invoice.id_for_plan).to eq 'Awesome invoice'

    plan = Stripe::Plan.retrieve(invoice.id_for_plan, stripe_account: vendor.stripe_uid)
    plan.delete
  end
end
