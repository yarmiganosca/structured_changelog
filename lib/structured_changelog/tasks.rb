Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rb')].each(&method(:require))

if Rake::Task.task_defined?('build')
  Rake::Task['build'].enhance %w(changelog:validate changelog:sync changelog:commit)
end
