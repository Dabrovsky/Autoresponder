# frozen_string_literal: true

module Tickets
  class Update < Command
    attribute :id, String
    attribute :customer_email, String
    attribute :message, String

    with_options presence: true do
      validates :id, :customer_email, :message
    end

    def call
      validate!
      return failure(entity) unless update!

      success(entity)
    end

    private

    def entity
      @entity ||= Ticket.find_by!(id:, customer_email:)
    end

    def update!
      entity.update!(entity_params)
    end

    def entity_params
      { message: }
    end
  end
end
