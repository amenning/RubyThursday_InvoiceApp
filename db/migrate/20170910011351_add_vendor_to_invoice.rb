class AddVendorToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :vendor, foreign_key: true
  end
end
