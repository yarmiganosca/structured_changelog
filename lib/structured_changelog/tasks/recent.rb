require 'structured_changelog'

desc 'Display N Recent Release Sections'
task 'changelog:recent', [:n, :path] do |_task, arguments|
  n    = arguments.to_h.fetch(:n)    { 3 }
  path = arguments.to_h.fetch(:path) { 'CHANGELOG.md' }

  changelog = StructuredChangelog.new(path)
  releases  = changelog.releases.to_a[0...n]

  puts releases.map(&:contents).join("\n\n")
end
