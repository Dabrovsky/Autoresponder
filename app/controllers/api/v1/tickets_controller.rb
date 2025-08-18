# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ApplicationController
      def index
        command = ::Tickets::List.call

        render json: TicketSerializer.new(
          command.value,
          is_collection: true
        ).serializable_hash
      end

      def create
        command = ::Tickets::Create.call(**ticket_params)

        render json: TicketSerializer.new(
          command.value
        ).serializable_hash, status: :created
      end

      def update
        command = ::Tickets::Update.call(**ticket_params, id: ticket_id)

        render json: TicketSerializer.new(
          command.value
        ).serializable_hash, status: :ok
      end

      def destroy
        ::Tickets::Destroy.call(id: ticket_id)

        render status: :no_content
      end

      private

      def ticket_id
        params[:id]
      end

      def ticket_params
        params.require(:ticket).permit(:customer_email, :message)
      end
    end
  end
end
