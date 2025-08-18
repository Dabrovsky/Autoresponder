# frozen_string_literal: true

require "rails_helper"

RSpec.describe AnswerSerializer, type: :serializer do
  describe ".new" do
    it "serializes answer representation with correct attributes" do
      answer = create(:openai_answer)

      expected_hash = {
        data: {
          id: answer.id.to_s,
          type: :answer,
          attributes: {
            status: answer.status,
            message: answer.message,
            rejected_reason: answer.rejected_reason,
            created_at: answer.created_at.to_s,
            updated_at: answer.updated_at.to_s
          }
        }
      }

      serialized_data = AnswerSerializer.new(answer).serializable_hash

      expect(serialized_data).to eq(expected_hash)
    end
  end
end
