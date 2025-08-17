# frozen_string_literal: true

# == Schema Information
#
# Table name: openai_answers
#
#  id              :uuid             not null, primary key
#  ticket_id       :uuid             not null
#  status          :string           not null
#  message         :text             not null
#  rejected_reason :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
module Openai
  class Answer < ApplicationRecord
    STATUSES = [
      PENDING = "pending",
      ACCEPTED = "accepted",
      REJECTED = "rejected"
    ].freeze

    enum :status, {
      pending: PENDING,
      accepted: ACCEPTED,
      rejected: REJECTED
    }, default: PENDING

    validates :status, :message, presence: true
    validates :rejected_reason, presence: true, if: :rejected?

    belongs_to :ticket
  end
end
