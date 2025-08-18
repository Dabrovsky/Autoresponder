# frozen_string_literal: true

module Tickets
  module Answers
    class List < Command
      attribute :id, String

      with_options presence: true do
        validates :id
      end

      def call
        validate!
        success(answers)
      end

      private

      def ticket
        @ticket ||= Ticket.find(id)
      end

      def answers
        ticket.answers
      end
    end
  end
end
