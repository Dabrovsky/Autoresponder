# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickets::Destroy do
  describe "Destroy class inheritance" do
    it "inherits from Command class" do
      expect(Tickets::Destroy.superclass).to eq(Command)
    end
  end

  describe ".call" do
    context "valid paramateres provided" do
      it "destroys a ticket from the database" do
        ticket = create(:ticket)
        input = {
          id: ticket.id
        }

        expect do
          Tickets::Destroy.new(**input).call
        end.to change(Ticket, :count).by(-1)
      end
    end

    context "invalid paramateres provided" do
      it "raises ActiveData::ValidationError" do
        input = {}
        expected_message = "Validation failed: Id can't be blank"

        expect do
          Tickets::Destroy.new(**input).call
        end.to raise_error(ActiveData::ValidationError, expected_message)
      end
    end
  end
end
