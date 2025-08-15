# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticket, type: :model do
  attr_reader :ticket

  before do
    @ticket = build(:ticket)
  end

  describe "validations" do
    context "when valid attributes" do
      it "is valid" do
        expect(ticket).to be_valid
      end
    end

    context "when customer_email is missing" do
      it "is invalid" do
        ticket.customer_email = nil

        expect(ticket).not_to be_valid
      end
    end

    context "when customer_email is incorrect" do
      it "is invalid" do
        ticket.customer_email = "invalid"

        expect(ticket).not_to be_valid
      end
    end

    context "when message is missing" do
      it "is invalid" do
        ticket.message = nil

        expect(ticket).not_to be_valid
      end
    end
  end

  describe "normalizations" do
    it "normalize customer_email" do
      ticket.customer_email = " joHndOe@examPle.Com "

      expect(ticket.customer_email).to eq("johndoe@example.com")
    end
  end
end
