# frozen_string_literal: true

require "rails_helper"

RSpec.describe Openai::File, type: :model do
  attr_reader :file

  before do
    @file = build(:openai_file)
  end

  describe "validations" do
    context "when valid attributes" do
      it "is valid" do
        expect(file).to be_valid
      end
    end

    context "when invalid attributes" do
      it "is invalid" do
        file.external_file_id = nil

        expect(file).to be_invalid
      end
    end
  end
end
