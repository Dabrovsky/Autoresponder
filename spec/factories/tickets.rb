# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    status { Ticket::PENDING }
    customer_email { "johndoe@example.com" }
    message { "Customer ticket message" }
  end
end
