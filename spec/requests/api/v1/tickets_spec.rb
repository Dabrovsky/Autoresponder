# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Tickets", type: :request do
  describe "GET /" do
    it "returns data collection" do
      ticket = create(:ticket)
      expected_response = {
        data: [
          {
            id: ticket.id.to_s,
            type: "ticket",
            attributes: {
              status: ticket.status,
              customer_email: ticket.customer_email,
              message: ticket.message,
              created_at: ticket.created_at.to_s,
              updated_at: ticket.updated_at.to_s
            }
          }
        ]
      }

      get(api_v1_tickets_path)

      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(expected_response)
    end
  end

  describe "POST /" do
    context "valid parameters provided" do
      it "creates a ticket" do
        params = {
          ticket: {
            customer_email: "johndoe@example.com",
            message: "My computer is broken. Could you help me?"
          }
        }

        post(api_v1_tickets_path, params:)

        expect(response).to have_http_status(:created)
      end
    end

    context "invalid parameters provided" do
      it "returns bad request" do
        params = {}

        post(api_v1_tickets_path, params:)

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "PATCH /" do
    context "valid parameters provided" do
      it "updates a ticket" do
        ticket = create(:ticket, message: "Example message")
        params = {
          ticket: {
            customer_email: "johndoe@example.com",
            message: "Updated message"
          }
        }

        expect(ticket.customer_email).to eq("johndoe@example.com")
        expect(ticket.message).to eq("Example message")

        patch(api_v1_ticket_path(ticket), params:)

        expected_response = {
          data: {
            id: ticket.reload.id.to_s,
            type: "ticket",
            attributes: {
              status: ticket.status,
              customer_email: "johndoe@example.com",
              message: "Updated message",
              created_at: ticket.created_at.to_s,
              updated_at: ticket.updated_at.to_s
            }
          }
        }

        expect(response).to have_http_status(:ok)
        expect(json_response).to eq(expected_response)
      end
    end

    context "invalid parameters provided" do
      it "returns bad request" do
        ticket = create(:ticket, message: "Example message")
        params = {}

        patch(api_v1_ticket_path(ticket), params:)

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "DELETE /" do
    it "destroys a ticket" do
      ticket = create(:ticket)

      delete(api_v1_ticket_path(ticket))

      expect(response).to have_http_status(:no_content)
    end
  end
end
