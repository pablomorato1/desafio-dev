# frozen_string_literal: true

class CreateProvider < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :name_provider, null: false
      t.string :name_owner, null: false

      t.timestamps
    end

    add_index :providers, :name_provider, unique: true
  end
end
