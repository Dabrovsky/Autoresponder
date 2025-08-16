# frozen_string_literal: true

source "https://rubygems.org"

gem "active_data"
gem "bootsnap", require: false
gem "jsonapi-serializer"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.0.2"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "thruster", require: false
gem "tzinfo-data", platforms: %i(windows jruby)

group :development do
  gem "annotaterb"
end

group :development, :test do
  gem "debug", platforms: %i(mri windows), require: "debug/prelude"
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 8.0.0"
  gem "rubocop-rails-omakase", require: false
end
