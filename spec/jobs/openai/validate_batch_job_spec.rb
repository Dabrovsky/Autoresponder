# frozen_string_literal: true

require "rails_helper"

RSpec.describe Openai::ValidateBatchJob, type: :job do
  before do
    stub_api_request
  end

  describe ".perform" do
    it "requests external api, creates answer record, updates batch status" do
      batch = create(:openai_batch)

      expect(batch.external_status).to eq(Openai::Batch::VALIDATING)
      expect do
        described_class.perform_now
      end.to change(Openai::Answer, :count).by(1)
      expect(batch.reload.external_status).to eq(Openai::Batch::COMPLETED)
    end
  end

  private

  def stub_api_request
    stub_request(:get, /api.openai.com/)
      .with(headers: { "Authorization" => "Bearer " })
      .to_return(
        status: 200,
        body: {
          custom_id: create(:ticket).id,
          status: "completed",
          response: { body: { choices: [{ message: { content: "example" } }] } }
        }.to_json,
        headers: {}
      )
  end
end
