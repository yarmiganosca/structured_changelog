require 'bundler/gem_tasks'
require 'structured_changelog'

desc 'Validate your Structured Changelog'
task 'structured_changelog:validate', [:path] do |_task, arguments|
  path = arguments.to_h.fetch(:path) { "CHANGELOG.md" }

  puts "\e[32mValid #{path}\e[0m" if StructuredChangelog.new(path).validate
end

if (guard_clean_task = Rake::Task['release:guard_clean'])
  guard_clean_task.enhance(['structured_changelog:validate'])
elsif (release_task = Rake::Task['release'])
  release_task.enhance(['structured_changelog:validate'])
end
