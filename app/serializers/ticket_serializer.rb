# frozen_string_literal: true

class TicketSerializer
  include JSONAPI::Serializer

  attribute :status
  attribute :customer_email
  attribute :message
  attribute :created_at do |object|
    object.created_at.to_s
  end
  attribute :updated_at do |object|
    object.updated_at.to_s
  end
end
