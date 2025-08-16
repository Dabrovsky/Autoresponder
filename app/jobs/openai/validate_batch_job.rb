# frozen_string_literal: true

module Openai
  class ValidateBatchJob < ApplicationJob
    queue_as :default

    def perform
      return if batches.empty?

      batches.each do |batch|
        response = client.fetch_batch(batch.external_batch_id)
        status = response.dig(:body, :status)
        batch.update!(external_status: status)
        next unless status == Openai::Batch::COMPLETED

        output_file_id = response.dig(:body, :output_file_id)
        response = client.fetch_content(output_file_id)

        ticket_id = response.dig(:body, :custom_id)
        message = response.dig(:body, :response, :body, :choices)[0].dig(:message, :content)

        Openai::Answer.create!(ticket_id:, status: Openai::Answer::PENDING, message:)
      end
    end

    private

    def batches
      @batches ||= Openai::Batch.processing
    end

    def client
      @client ||= ApiClients::Openai::Client.new
    end
  end
end
