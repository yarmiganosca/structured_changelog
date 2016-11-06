require 'structured_changelog'

desc 'Display the Current Version'
task 'changelog:version', [:path] do |_task, arguments|
  path = arguments.to_h.fetch(:path) { "CHANGELOG.md" }

  changelog = StructuredChangelog.new(path)

  puts changelog.version
end
