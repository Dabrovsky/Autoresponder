# frozen_string_literal: true

module Tickets
  module Answers
    class Reject < Command
      attribute :id, String
      attribute :rejected_reason, String

      with_options presence: true do
        validates :id, :rejected_reason
      end

      def call
        validate!
        return failure(entity) unless update!

        success(entity)
      end

      private

      def entity
        @entity ||= Openai::Answer.find(id)
      end

      def update!
        entity.update!(entity_params)
      end

      def entity_params
        { status: Openai::Answer::REJECTED, rejected_reason: }
      end
    end
  end
end
