# frozen_string_literal: true

require "rails_helper"

RSpec.describe Batch, type: :model do
  attr_reader :batch

  before do
    @batch = build(:batch)
  end

  describe "validations" do
    context "when valid attributes" do
      it "is valid" do
        expect(batch).to be_valid
      end
    end

    context "when invalid attributes" do
      it "is invalid" do
        batch.external_batch_id = nil

        expect(batch).to be_invalid
      end
    end
  end
end
