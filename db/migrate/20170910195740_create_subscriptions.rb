class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :invoice, foreign_key: true
      t.string :id_for_subscription
      t.string :id_for_customer

      t.timestamps
    end
  end
end
