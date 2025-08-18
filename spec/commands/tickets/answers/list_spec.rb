# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickets::Answers::List do
  describe "List class inheritance" do
    it "inherits from Command class" do
      expect(Tickets::Answers::List.superclass).to eq(Command)
    end
  end

  describe ".call" do
    it "returns an array as a response value" do
      ticket = create(:ticket)
      answers = create_pair(:openai_answer, ticket:)
      output = Tickets::Answers::List.call(id: ticket.id)

      expect(output.value.count).to eq(2)
      expect(output.value).to eq(answers)
    end
  end
end
