# frozen_string_literal: true

module ApiClients
  module Openai
    class Client < ApiClient
      CLIENT = "OPENAI"
      API_PATH = "https://api.openai.com/v1"
      CONTENT_TYPES = [
        APPLICATION_JSON = "application/json",
        MULTIPART_FORM = "multipart/form-data"
      ].freeze

      def fetch_batches
        set_json_content_type
        get("/batches")
      end

      def fetch_batch(batch_id = nil)
        set_json_content_type
        get("/batches/#{batch_id}")
      end

      def fetch_content(file_id)
        set_json_content_type
        get("/files/#{file_id}/content")
      end

      def create_batch(file_id)
        set_json_content_type
        input = {
          input_file_id: file_id,
          endpoint: "/v1/chat/completions",
          completion_window: "24h"
        }

        post("/batches", input.to_json)
      end

      def upload_file(file)
        set_multipart_content_type
        input = { purpose: "batch", file: }

        post("/files", input)
      end

      private

      def set_json_content_type
        @content_type = APPLICATION_JSON
      end

      def set_multipart_content_type
        @content_type = MULTIPART_FORM
      end
    end
  end
end
