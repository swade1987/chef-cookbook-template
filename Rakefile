require 'rubocop/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'
require 'kitchen'

FoodCritic::Rake::LintTask.new
RSpec::Core::RakeTask.new

# Foodcritic task
desc 'Run Foodcritic style checks'
task style: [:foodcritic]

# ChefSpec task
desc 'Run all style checks and unit tests'
task test: [:style, :spec]

# Integration tests using Test Kitchen (http://kitchen.ci/)
namespace :integration do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
end

# Default
task default: ['test', 'integration:vagrant']