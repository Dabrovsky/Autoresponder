# frozen_string_literal: true

# == Schema Information
#
# Table name: openai_batches
#
#  id                :uuid             not null, primary key
#  external_batch_id :string           not null
#  external_status   :string           not null
#  ticket_ids        :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
module Openai
  class Batch < ApplicationRecord
    # external statuses mapped from https://platform.openai.com/docs/guides/batch#4-check-the-status-of-a-batch
    EXTERNAL_STATUSES = [
      VALIDATING = "validating",
      FAILED = "failed",
      IN_PROGRESS = "in_progress",
      FINALIZING = "finalizing",
      COMPLETED = "completed",
      EXPIRED = "expired",
      CANCELLING = "cancelling",
      CANCELED = "cancelled"
    ].freeze

    enum :external_status, {
      validating: VALIDATING,
      failed: FAILED,
      in_progress: IN_PROGRESS,
      finalizing: FINALIZING,
      completed: COMPLETED,
      expired: EXPIRED,
      cancelling: CANCELLING,
      cancelled: CANCELED
    }, default: VALIDATING

    with_options presence: true do
      validates :external_batch_id, :external_status
    end
  end
end
