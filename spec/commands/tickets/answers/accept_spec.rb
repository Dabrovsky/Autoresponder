# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickets::Answers::Accept do
  describe "Update class inheritance" do
    it "inherits from Command class" do
      expect(Tickets::Answers::Accept.superclass).to eq(Command)
    end
  end

  describe ".call" do
    context "valid paramateres provided" do
      it "updates a answer entity" do
        answer = create(:openai_answer)

        output = Tickets::Answers::Accept.call(id: answer.id)

        expect(output.value).to be_an_instance_of(Openai::Answer)
        expect(output.value.status).to eq(Openai::Answer::ACCEPTED)
      end
    end

    context "invalid paramateres provided" do
      it "raises ActiveData::ValidationError" do
        expected_message = "Validation failed: Id can't be blank"

        expect do
          Tickets::Answers::Accept.call
        end.to raise_error(ActiveData::ValidationError, expected_message)
      end
    end
  end
end
