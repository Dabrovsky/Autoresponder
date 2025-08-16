# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickets::List do
  describe "List class inheritance" do
    it "inherits from Command class" do
      expect(Tickets::List.superclass).to eq(Command)
    end
  end

  describe ".call" do
    it "returns an array as a response value" do
      tickets = create_pair(:ticket)
      output = Tickets::List.new.call

      expect(output.value.count).to eq(2)
      expect(output.value).to eq(tickets)
    end
  end
end
