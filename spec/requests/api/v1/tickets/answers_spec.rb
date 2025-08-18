# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Tickets::Answers", type: :request do
  describe "GET /" do
    it "returns data collection" do
      answer = create(:openai_answer)
      expected_response = {
        data: [
          {
            id: answer.id.to_s,
            type: "answer",
            attributes: {
              status: answer.status,
              message: answer.message,
              rejected_reason: answer.rejected_reason,
              created_at: answer.created_at.to_s,
              updated_at: answer.updated_at.to_s
            }
          }
        ]
      }

      get(api_v1_ticket_answers_path(answer.ticket))

      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(expected_response)
    end
  end

  describe "PATCH /" do
    context "accept" do
      it "updates an answer" do
        answer = create(:openai_answer)

        expect(answer.status).to eq(Openai::Answer::PENDING)

        patch(accept_api_v1_ticket_answer_path(answer.ticket, answer))

        expected_response = {
          data: {
            id: answer.reload.id.to_s,
            type: "answer",
            attributes: {
              status: Openai::Answer::ACCEPTED,
              message: answer.message,
              rejected_reason: answer.rejected_reason,
              created_at: answer.created_at.to_s,
              updated_at: answer.updated_at.to_s
            }
          }
        }

        expect(response).to have_http_status(:ok)
        expect(json_response).to eq(expected_response)
      end
    end

    context "reject" do
      context "valid parameters provided" do
        it "updates an answer" do
          answer = create(:openai_answer)
          params = {
            answer: {
              rejected_reason: "Rejected message"
            }
          }

          expect(answer.status).to eq(Openai::Answer::PENDING)

          patch(reject_api_v1_ticket_answer_path(answer.ticket, answer), params:)

          expected_response = {
            data: {
              id: answer.reload.id.to_s,
              type: "answer",
              attributes: {
                status: Openai::Answer::REJECTED,
                message: answer.message,
                rejected_reason: "Rejected message",
                created_at: answer.created_at.to_s,
                updated_at: answer.updated_at.to_s
              }
            }
          }

          expect(response).to have_http_status(:ok)
          expect(json_response).to eq(expected_response)
        end
      end

      context "invalid parameters provided" do
      it "returns bad request" do
        answer = create(:openai_answer)

        patch(reject_api_v1_ticket_answer_path(answer.ticket, answer))

        expect(response).to have_http_status(:bad_request)
      end
    end
    end
  end
end
