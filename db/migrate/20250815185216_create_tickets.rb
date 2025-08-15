# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets, id: :uuid do |t|
      t.string :status, null: false
      t.string :customer_email, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
