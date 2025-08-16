# frozen_string_literal: true

require "rails_helper"

RSpec.describe BatchFileBuilder do
  attr_reader :builder

  before do
    @builder = described_class.new
  end

  after do
    File.delete(described_class::FILE_PATH) if File.exist?(described_class::FILE_PATH)
  end

  describe ".call" do
    it "creates a file and returns its path" do
      tickets = create_pair(:ticket)
      path = builder.call(tickets)

      expect(path).to eq(described_class::FILE_PATH)
      expect(File.exist?(path)).to be_truthy
    end

    it "returns nil when passed params are blank" do
      expect(builder.call([])).to be_nil
      expect(builder.call(nil)).to be_nil
    end
  end
end
