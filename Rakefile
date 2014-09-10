require "bundler/gem_tasks"

require 'coveralls/rake/task'

require 'rake/testtask'

task :test do
  Rake::Task['test:unit'].invoke
  Rake::Task['test:integration'].invoke
end

namespace :test do
  Rake::TestTask.new("integration") do |t|
    t.libs << "test"
    t.libs << "config"
    t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new("unit") do |t|
    t.libs << "test"
    t.libs << "config"
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
  end
end

Coveralls::RakeTask.new

task :test_with_coveralls => ['test:unit', 'test:integration', 'coveralls:push']

task :default => :test_with_coveralls
