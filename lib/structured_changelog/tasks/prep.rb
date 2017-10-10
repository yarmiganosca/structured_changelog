desc "Validates your Changelog, updates your VERSION constant, then commits that (when you want to PR releases)"
task "changelog:prep", [:repo_path, :changelog_path, :version_path] do |_task, arguments|
  Rake::Task['changelog:validate'].execute(arguments)
  Rake::Task['changelog:sync'].execute(arguments)
  `bundle`
  Rake::Task['changelog:commit'].execute(arguments)
end
