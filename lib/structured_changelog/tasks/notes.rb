require 'structured_changelog'

desc "Display Release Notes for One or Multiple Versions"
task "changelog:notes", [:query, :path] do |_task, arguments|
  query = arguments.to_h.fetch(:query) { "current" }
  path  = arguments.to_h.fetch(:path)  { "CHANGELOG.md" }

  changelog = StructuredChangelog.new(path)
  releases  = changelog.find_releases(query)

  puts releases.map(&:contents).join("\n\n")
end

