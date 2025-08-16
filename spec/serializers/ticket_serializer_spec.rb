# frozen_string_literal: true

require "rails_helper"

RSpec.describe TicketSerializer, type: :serializer do
  describe ".new" do
    it "serializes ticket representation with correct attributes" do
      ticket = create(:ticket)

      expected_hash = {
        data: {
          id: ticket.id.to_s,
          type: :ticket,
          attributes: {
            status: ticket.status,
            customer_email: ticket.customer_email,
            message: ticket.message,
            created_at: ticket.created_at.to_s,
            updated_at: ticket.updated_at.to_s
          }
        }
      }

      serialized_data = TicketSerializer.new(ticket).serializable_hash

      expect(serialized_data).to eq(expected_hash)
    end
  end
end
