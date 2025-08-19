# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id             :uuid             not null, primary key
#  status         :string           not null
#  customer_email :string           not null
#  message        :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Ticket < ApplicationRecord
  STATUSES = [
    PENDING = "pending",
    PROCESSING = "processing",
    CLOSED = "closed"
  ].freeze

  enum :status, {
    pending: PENDING,
    processing: PROCESSING,
    closed: CLOSED
  }, default: PENDING

  with_options presence: true do
    validates :status, :message
    validates :customer_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end

  normalizes :customer_email, with: -> { it.squish.downcase }

  has_one :last_answer, -> { order(created_at: :desc) }, class_name: "Openai::Answer", dependent: :destroy
  has_many :answers, class_name: "Openai::Answer", dependent: :destroy

  scope :with_rejected_answer, lambda {
    joins(<<~SQL)
      JOIN (
        SELECT a.id, a.ticket_id, a.status
        FROM openai_answers a
        JOIN (
          SELECT ticket_id, MAX(created_at) AS max_created_at
          FROM openai_answers
          GROUP BY ticket_id
        ) m ON m.ticket_id = a.ticket_id AND m.max_created_at = a.created_at AND a.status = '#{Openai::Answer::REJECTED}'
      ) last_answers
      ON last_answers.ticket_id = tickets.id
    SQL
  }
end
