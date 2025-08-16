# frozen_string_literal: true

class CreateBatches < ActiveRecord::Migration[8.0]
  def change
    create_table :batches, id: :uuid do |t|
      t.string :external_batch_id, null: false
      t.string :external_status, null: false
      t.jsonb :ticket_ids, default: []
      t.timestamps
    end
  end
end
