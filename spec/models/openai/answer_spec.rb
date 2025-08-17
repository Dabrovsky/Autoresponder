# frozen_string_literal: true

require "rails_helper"

RSpec.describe Openai::Answer, type: :model do
  attr_reader :answer

  before do
    @answer = build(:openai_answer)
  end

  describe "validations" do
    context "when valid attributes" do
      it "is valid" do
        expect(answer).to be_valid
      end
    end

    context "when rejected" do
      it "rejected_reason is required" do
        answer.status = Openai::Answer::REJECTED

        expect(answer).to be_invalid
      end
    end
  end
end
