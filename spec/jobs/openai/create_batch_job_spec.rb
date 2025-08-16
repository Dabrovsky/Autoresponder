# frozen_string_literal: true

require "rails_helper"

RSpec.describe Openai::CreateBatchJob, type: :job do
  before do
    stub_api_request
  end

  describe ".perform" do
    it "requests external api, creates batch record, updates ticket status" do
      ticket = create(:ticket)

      expect(ticket.status).to eq(Ticket::PENDING)
      expect do
        described_class.perform_now
      end.to change(Openai::Batch, :count).by(1)
      expect(ticket.reload.status).to eq(Ticket::PROCESSING)
    end
  end

  private

  def stub_api_request
    stub_request(:post, /api.openai.com/)
      .with(headers: { "Authorization" => "Bearer " })
      .to_return(status: 200, body: { id: SecureRandom.uuid, status: "validating" }.to_json, headers: {})
  end
end
