# frozen_string_literal: true

# == Schema Information
#
# Table name: openai_files
#
#  id               :uuid             not null, primary key
#  external_file_id :string           not null
#  status           :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
module Openai
  class File < ApplicationRecord
    STATUSES = [
      CREATED = "created",
      PROCESSED = "processed"
    ].freeze

    enum :status, {
      created: CREATED,
      processed: PROCESSED
    }, default: CREATED

    with_options presence: true do
      validates :external_file_id, :status
    end
  end
end
