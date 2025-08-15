# frozen_string_literal: true

# The Response class represents a response object that
# can be used to represent success or failure outcomes
class Response
  attr_reader :value

  def self.success(value)
    new(success: true, value:)
  end

  def self.failure(value)
    new(success: false, value:)
  end

  def initialize(success:, value: nil)
    @success = success
    @value = value
  end

  def success?
    @success == true
  end

  def failure?
    !success?
  end
end
