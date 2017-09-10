class AddStripeConnectInfoToVendor < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :stripe_access_token, :string
    add_column :vendors, :stripe_refresh_token, :string
    add_column :vendors, :stripe_publishable_key, :string
    add_column :vendors, :stripe_user_id, :string
    add_column :vendors, :provider, :string
  end
end
