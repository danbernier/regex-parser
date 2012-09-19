require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test*.rb']
end

task :generate_parser do
  puts `tt lib/regex_parser.treetop`
end

task :test => :generate_parser

task :default => :test
