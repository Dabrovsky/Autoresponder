# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickets::Create do
  describe "Create class inheritance" do
    it "inherits from Command class" do
      expect(Tickets::Create.superclass).to eq(Command)
    end
  end

  describe ".call" do
    context "valid paramateres provided" do
      it "creates a ticket entity" do
        input = {
          customer_email: "johndoe@example.com",
          message: "Message content"
        }

        expect do
          Tickets::Create.call(**input)
        end.to change(Ticket, :count).by(1)
      end
    end

    context "invalid paramateres provided" do
      it "raises ActiveData::ValidationError" do
        input = {}
        expected_message = "Validation failed: Customer email can't be blank, Message can't be blank"

        expect do
          Tickets::Create.call(**input)
        end.to raise_error(ActiveData::ValidationError, expected_message)
      end
    end
  end
end
