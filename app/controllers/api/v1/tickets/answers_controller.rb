# frozen_string_literal: true

module Api
  module V1
    module Tickets
      class AnswersController < ApplicationController
        def index
          command = ::Tickets::Answers::List.call(id: ticket_id)

          render json: AnswerSerializer.new(
            command.value,
            is_collection: true
          ).serializable_hash
        end

        def accept
          command = ::Tickets::Answers::Accept.call(id: answer_id)

          render json: AnswerSerializer.new(
            command.value
          ).serializable_hash, status: :ok
        end

        def reject
          command = ::Tickets::Answers::Reject.call(**answer_params, id: answer_id)

          render json: AnswerSerializer.new(
            command.value
          ).serializable_hash, status: :ok
        end

        private

        def ticket_id
          params[:ticket_id]
        end

        def answer_id
          params[:id]
        end

        def answer_params
          params.require(:answer).permit(:rejected_reason)
        end
      end
    end
  end
end
