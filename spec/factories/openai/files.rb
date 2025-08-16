# frozen_string_literal: true

FactoryBot.define do
  factory :openai_file, class: "Openai::File" do
    external_file_id { SecureRandom.uuid }
    status { Openai::File::CREATED }
  end
end
