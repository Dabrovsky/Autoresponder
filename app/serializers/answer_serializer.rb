# frozen_string_literal: true

class AnswerSerializer
  include JSONAPI::Serializer

  attribute :status
  attribute :message
  attribute :rejected_reason
  attribute :created_at do |object|
    object.created_at.to_s
  end
  attribute :updated_at do |object|
    object.updated_at.to_s
  end
end
