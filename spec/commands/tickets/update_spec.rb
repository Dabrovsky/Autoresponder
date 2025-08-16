# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickets::Update do
  describe "Update class inheritance" do
    it "inherits from Command class" do
      expect(Tickets::Update.superclass).to eq(Command)
    end
  end

  describe ".call" do
    context "valid paramateres provided" do
      it "updates a ticket entity" do
        ticket = create(:ticket, customer_email: "johndoe@example.com", message: "Test message")
        input = {
          id: ticket.id,
          customer_email: "johndoe@example.com",
          message: "Updated message"
        }

        output = Tickets::Update.new(**input).call

        expect(output.value).to be_an_instance_of(Ticket)
        expect(output.value.message).to eq("Updated message")
      end
    end

    context "invalid paramateres provided" do
      it "raises ActiveData::ValidationError" do
        input = {}
        expected_message = "Validation failed: Id can't be blank, Customer email can't be blank, Message can't be blank"

        expect do
          Tickets::Update.new(**input).call
        end.to raise_error(ActiveData::ValidationError, expected_message)
      end
    end
  end
end
