# frozen_string_literal: true

class CreateOpenaiFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :openai_files, id: :uuid do |t|
      t.string :external_file_id, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
