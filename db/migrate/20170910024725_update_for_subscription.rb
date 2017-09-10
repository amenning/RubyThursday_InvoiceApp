class UpdateForSubscription < ActiveRecord::Migration[5.1]
  def change
    rename_column :vendors, :stripe_user_id, :stripe_uid
    add_column :invoices, :id_for_plan, :string
  end
end
