# frozen_string_literal: true

module ApiClients
  module Openai
    class Client < ApiClient
      CLIENT = "OPENAI"
      API_PATH = "https://api.openai.com/v1"

      def fetch_batches
        get("/batches")
      end

      def fetch_batch(batch_id = nil)
        get("/batches/#{batch_id}")
      end

      def fetch_content(file_id)
        get("/files/#{file_id}/content")
      end

      def upload_file(file)
        input = { purpose: "batch", file: }

        post("/files", input)
      end

      def create_batches(file_id)
        input = {
          input_file_id: file_id,
          endpoint: "/v1/chat/completions",
          completion_window: "24h"
        }

        post("/batches", input.as_json)
      end
    end
  end
end
