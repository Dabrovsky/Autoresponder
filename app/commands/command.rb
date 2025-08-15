# frozen_string_literal: true

class Command
  include ActiveData::Model

  attr_reader :input

  def initialize(**input)
    @input = input
    assign_attributes
  end

  def self.call(**input)
    new(**input).call
  end

  def call
    raise NotImplementedError, "#{self.class} must implement #call"
  end

  protected

  def success(value = nil)
    Response.success(value)
  end

  def failure(value = nil)
    Response.failure(value)
  end

  private

  def validate_input!
    validate!
  rescue ActiveData::ValidationError
    false
  end

  def assign_attributes
    input.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end
end
