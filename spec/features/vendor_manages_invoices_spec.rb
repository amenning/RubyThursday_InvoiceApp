require 'rails_helper'

feature 'Vendor manages invoices' do
  let :vendor { FactoryGirl.create(:vendor) }

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
    # ADD MAKE SURE SUBSCRIPTION CREATED
  end
end
