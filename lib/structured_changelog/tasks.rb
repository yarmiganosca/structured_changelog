Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rb')].each(&method(:require))

if Rake::Task.task_defined?('release')
  Rake::Task['release'].enhance %w(changelog:validate changelog:sync)
end
