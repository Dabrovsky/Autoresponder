# frozen_string_literal: true

source "https://rubygems.org"

gem "active_data"
gem "bootsnap", require: false
gem "jsonapi-serializer"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.1.1"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "thruster", require: false
gem "typhoeus"
gem "tzinfo-data", platforms: %i(windows jruby)
gem "whenever", require: false

group :development do
  gem "annotaterb"
end

group :development, :test do
  gem "debug", platforms: %i(mri windows), require: "debug/prelude"
  gem "dotenv"
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 8.0.0"
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "webmock"
end
