# frozen_string_literal: true

module Openai
  class CreateBatchJob < ApplicationJob
    queue_as :default

    attr_reader :file_id

    def perform
      return if tickets.empty?

      file = prepare_batch_file
      response = client.create_batch(file[:id])

      ActiveRecord::Base.transaction do
        Openai::Batch.create!(
          external_batch_id: response.dig(:body, :id),
          external_status: response.dig(:body, :status)
        )

        tickets.map { it.update!(status: Ticket::PROCESSING) }
      end
    end

    private

    def tickets
      @tickets ||= [Ticket.pending, Ticket.processing.with_rejected_answer].flatten
    end

    def client
      @client ||= ApiClients::Openai::Client.new
    end

    def prepare_batch_file
      file_path = BatchFileBuilder.new.call(tickets)
      file = File.open(file_path, "rb")

      response = client.upload_file(file)
      File.delete(file_path) if File.exist?(file_path)

      response[:body]
    end
  end
end
