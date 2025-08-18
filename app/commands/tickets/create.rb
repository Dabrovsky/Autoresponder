# frozen_string_literal: true

module Tickets
  class Create < Command
    attribute :customer_email, String
    attribute :message, String

    with_options presence: true do
      validates :customer_email, :message
    end

    def call
      validate!
      return failure(entity) unless save!

      success(entity)
    end

    private

    def entity
      @entity ||= Ticket.new(entity_params)
    end

    def save!
      entity.save!
    end

    def entity_params
      { customer_email:, message: }
    end
  end
end
