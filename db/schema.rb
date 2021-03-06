# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170911235404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.string "id_for_plan"
    t.index ["vendor_id"], name: "index_invoices_on_vendor_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "invoice_id"
    t.string "id_for_subscription"
    t.string "id_for_customer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_email"
    t.index ["invoice_id"], name: "index_subscriptions_on_invoice_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_access_token"
    t.string "stripe_refresh_token"
    t.string "stripe_publishable_key"
    t.string "stripe_uid"
    t.string "provider"
    t.index ["email"], name: "index_vendors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_vendors_on_reset_password_token", unique: true
  end

  add_foreign_key "invoices", "vendors"
  add_foreign_key "subscriptions", "invoices"
end
