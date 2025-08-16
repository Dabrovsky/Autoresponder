# frozen_string_literal: true

FactoryBot.define do
  factory :batch do
    external_batch_id { SecureRandom.uuid }
    external_status { Batch::VALIDATING }
  end
end
