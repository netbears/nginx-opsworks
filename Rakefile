# Inspeired by: https://github.com/burtlo/cookbook-raketasks/blob/master/lib/cookbook/raketasks/spec.rb

require 'rake'
require 'rspec/core/rake_task'
require 'dotenv/tasks'
require 'rubocop/rake_task'
require 'kitchen'

module Cookbook
  module Raketasks
    extend Rake::DSL

    desc 'Run all tasks'
    task default: ['rubocop:auto_correct', :spec]

    desc 'Run all specs'
    task spec: ['spec:unit', 'spec:integration']

    desc 'Run ChefSpec examples'
    RSpec::Core::RakeTask.new('spec:unit')

    desc 'Run Test Kitchen'
    task 'spec:integration' => :dotenv do
      Kitchen.logger = Kitchen.default_file_logger
      Kitchen::Config.new.instances.each do |instance|
        instance.test(:always)
      end
    end

    task 'kitchen:verify' => :dotenv do
      Kitchen.logger = Kitchen.default_file_logger
      Kitchen::Config.new.instances.each(&:verify)
    end

    desc 'Run rubocop'
    RuboCop::RakeTask.new('rubocop')
  end
end
