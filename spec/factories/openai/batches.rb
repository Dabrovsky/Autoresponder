# frozen_string_literal: true

FactoryBot.define do
  factory :openai_batch, class: "Openai::Batch" do
    external_batch_id { SecureRandom.uuid }
    external_status { Openai::Batch::VALIDATING }
  end
end
