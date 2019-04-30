require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task(:berks) do
  sh 'bundle exec berks install'
end

task(:kitchen) do
  sh 'kitchen test'
end

task(:kitchen_ci) do
  sh 'source /opt/test-kitchen/kitchen_wrapper.sh && bundle exec kitchen test -c'
end

task ci: [:berks, :spec, :kitchen_ci]

task default: [:berks, :spec]
