
env :GEM_HOME, ENV["GEM_HOME"]
set :environment, "development"
set :output, "#{path}/log/cron.log"

job_type :runner, "cd :path && bundle exec rails runner -e :environment ':task' :output"

every 5.minutes do
  runner "Openai::CreateBatchJob.perform_now"
end

every 3.minutes do
  runner "Openai::ValidateBatchJob.perform_now"
end
