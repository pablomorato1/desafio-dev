# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_17_211827) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_customers_on_cpf", unique: true
  end

  create_table "providers", force: :cascade do |t|
    t.string "name_provider", null: false
    t.string "name_owner", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_provider"], name: "index_providers_on_name_provider", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "provider_id", null: false
    t.integer "transaction_type", null: false
    t.string "date_register", null: false
    t.float "value", null: false
    t.string "card_number", null: false
    t.string "hour_transaction", null: false
    t.boolean "is_income", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_transactions_on_customer_id"
    t.index ["provider_id"], name: "index_transactions_on_provider_id"
  end

  add_foreign_key "transactions", "customers"
  add_foreign_key "transactions", "providers"
end
