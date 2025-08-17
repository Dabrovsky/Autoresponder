# frozen_string_literal: true

FactoryBot.define do
  factory :openai_answer, class: "Openai::Answer" do
    association :ticket
    status { Openai::Answer::PENDING }
    message { "Example message" }
  end
end
