class AddCustomerEmailToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :customer_email, :string
  end
end
