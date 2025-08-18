# frozen_string_literal: true

module Tickets
  module Answers
    class Accept < Command
      attribute :id, String

      with_options presence: true do
        validates :id
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
        ActiveRecord::Base.transaction do
          entity.update!(entity_params)
          entity.ticket.update!(status: Ticket::CLOSED)
        end
      end

      def entity_params
        { status: Openai::Answer::ACCEPTED }
      end
    end
  end
end
