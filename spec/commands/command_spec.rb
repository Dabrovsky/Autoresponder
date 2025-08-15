# frozen_string_literal: true

require "rails_helper"

RSpec.describe Command do
  describe ".call" do
    it "raises NotImplementedError" do
      input = {}

      expect { described_class.call(**input) }.to raise_error(NotImplementedError)
    end
  end
end
