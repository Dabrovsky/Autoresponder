# frozen_string_literal: true

module Tickets
  class Destroy < Command
    attribute :id, String

    with_options presence: true do
      validates :id
    end

    def call
      validate!
      return failure(entity) unless destroy!

      success(entity)
    end

    private

    def entity
      @entity ||= Ticket.find(id)
    end

    def destroy!
      entity.destroy
    end
  end
end
