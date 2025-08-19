# frozen_string_literal: true

class BatchFileBuilder
  FILE_PATH = Rails.root.join("tmp", "batch_#{Time.zone.now.to_i}.jsonl")
  GPT_MODEL = "gpt-5-mini"
  SYSTEM_PROMPT = <<~PROMPT.strip
    You are a professional computer service assistant working in a local town repair shop.
    Respond as a human expert would: practical, clear, and to the point.
    Always answer in the same language as the user's message, and keep your response concise and easy to understand.
  PROMPT

  def call(tickets)
    return if tickets.blank?

    File.open(FILE_PATH, "w") do |file|
      tickets.each do |ticket|
        content = {
          custom_id: ticket.id,
          method: "POST",
          url: "/v1/chat/completions",
          body: {
            model: GPT_MODEL,
            messages: [
              { role: "system", content: SYSTEM_PROMPT },
              { role: "user", content: message_content(ticket) }
            ]
          }
        }

        file.puts(content.to_json)
      end
    end

    FILE_PATH
  end

  private

  def message_content(ticket)
    message = ticket.message
    return message if ticket.pending?

    "#{message}\n\nTake into account additional instruction: #{ticket.last_answer.rejected_reason}"
  end
end
