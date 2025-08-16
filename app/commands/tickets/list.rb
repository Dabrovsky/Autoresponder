# frozen_string_literal: true

module Tickets
  class List < Command
    def call
      success(tickets)
    end

    private

    def tickets
      Ticket.all
    end
  end
end
