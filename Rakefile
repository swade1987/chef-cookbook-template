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

  desc 'Run Test Kitchen with cloud plugins'
  task :cloud, :pattern do
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
    config = Kitchen::Config.new(loader: @loader)
    config.instances.each do |instance|
      instance.test(:always)
    end
  end
end

task :upload_to_chef do
  sh 'berks install; berks upload'
end

# Execute the packer build to produce us a new AMI
task :packer, :source_ami_id do |_, args|
  puts args[:source_ami_id]
  sh 'rm -rf berks-cookbooks/*'
  sh 'berks vendor'
  sh 'packer validate template.json'
  sh "packer build -var 'source_ami=#{args.source_ami_id}' template.json"
end

task default: ['test', 'integration:vagrant']
task ci: ['test', 'upload_to_chef']
task cloud: ['test', 'integration:cloud', 'upload_to_chef']
