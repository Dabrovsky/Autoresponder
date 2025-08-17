# frozen_string_literal: true

class CreateOpenaiAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :openai_answers, id: :uuid do |t|
      t.references :ticket, null: false, foreign_key: true, type: :uuid
      t.string :status, null: false
      t.text :message, null: false
      t.text :rejected_reason
      t.timestamps
    end
  end
end
