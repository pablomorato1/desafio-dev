# frozen_string_literal: true

class CreateTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true
      t.integer :transaction_type, null: false
      t.string :date_register, null: false
      t.float :value, null: false
      t.string :card_number, null: false
      t.string :hour_transaction, null: false
      t.boolean :is_income, null: false

      t.timestamps
    end
  end
end
