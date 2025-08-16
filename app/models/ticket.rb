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

  has_many :answers, class_name: "Openai::Answer", dependent: :destroy

  scope :with_rejected_answers, -> { where(openai_answers: { status: Openai::Answer::REJECTED }) }
end
