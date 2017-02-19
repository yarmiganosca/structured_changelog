Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rb')].each(&method(:require))

if Rake::Task.task_defined?('release:guard_clean')
  Rake::Task['release:guard_clean'].enhance %w(changelog:validate changelog:sync changelog:commit)
elsif Rake::Task.task_defined?('release')
  Rake::Task['release'].enhance %w(changelog:validate changelog:sync changelog:commit)
end
