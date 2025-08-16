# frozen_string_literal: true

class CreateOpenaiBatches < ActiveRecord::Migration[8.0]
  def change
    create_table :openai_batches, id: :uuid do |t|
      t.string :external_batch_id, null: false
      t.string :external_status, null: false
      t.timestamps
    end
  end
end
