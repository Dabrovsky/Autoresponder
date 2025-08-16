# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApiClients::ApiClient do
  API_PATH = "https://api.example.com"
  API_KEY = "secret"

  attr_reader :client, :expected_response_body

  before do
    @client = described_class.new(api_path: API_PATH, api_key: API_KEY)
    @expected_response_body = { success: true }.as_json
  end

  describe ".get" do
    it "sends GET request" do
      stub_api_request(type: :get)
      response = client.get("/example_endpoint")

      expect(response[:code]).to eq(200)
      expect(response[:body]).to eq(expected_response_body)
    end
  end

  describe ".post" do
    it "sends POST request" do
      stub_api_request(type: :post)
      response = client.post("/example_endpoint")

      expect(response[:code]).to eq(200)
      expect(response[:body]).to eq(expected_response_body)
    end
  end

  describe ".put" do
    it "sends PUT request" do
      stub_api_request(type: :put)
      response = client.put("/example_endpoint")

      expect(response[:code]).to eq(200)
      expect(response[:body]).to eq(expected_response_body)
    end
  end

  describe ".delete" do
    it "sends DELETE request" do
      stub_api_request(type: :delete)
      response = client.delete("/example_endpoint")

      expect(response[:code]).to eq(200)
      expect(response[:body]).to eq(expected_response_body)
    end
  end

  private

  def stub_api_request(type:)
    stub_request(type, "#{API_PATH}/example_endpoint")
      .with(headers: { "Authorization" => "Bearer #{API_KEY}" })
      .to_return(status: 200, body: { success: true }.to_json, headers: { "Content-Type" => "application/json" })
  end
end
