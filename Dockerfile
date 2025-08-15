# Use the official Ruby base image
FROM ruby:3.4-alpine

# Install system dependencies required for Rails and MySQL
RUN apk update && apk add --no-cache \
  build-base \
  postgresql-client \
  postgresql-dev \
  yaml-dev \
  tzdata \
  git

# Set the working directory inside the container
WORKDIR /app

# Install Rails dependencies (based on your Gemfile)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy root files
COPY config.ru \
  .rubocop.yml \
  Rakefile \
  ./

# Copy directories
COPY bin bin
COPY config config
COPY db db
COPY public public
COPY script script
COPY .github .github

# Cop most updated directories last
COPY spec spec
COPY lib lib
COPY app app

# Set up the entrypoint to start the Rails server
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0"]

# Expose the default Rails port
EXPOSE 3000
