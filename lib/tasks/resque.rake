require 'resque/tasks'

task 'resque:setup' => :environment

# require 'resque/tasks'
# require 'resque/scheduler/tasks'

# namespace :resque do
#   task :setup do
#     require 'resque'
#     require 'resque-scheduler'
#   end
# end