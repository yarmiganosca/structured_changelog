require 'structured_changelog'
require 'structured_changelog/version_pattern'

desc "Set the gem's VERSION constant to be the changelog's version"
task 'changelog:sync', [:changelog_path, :version_path] do |_task, arguments|
  changelog_path = arguments.to_h.fetch(:changelog_path) { "CHANGELOG.md" }
  version_path   = arguments.to_h.fetch(:version_path)   { "lib/#{Pathname.pwd.basename}/version.rb" }

  changelog    = StructuredChangelog.new(changelog_path)
  version_file = Pathname.new(version_path)

  version_file.write(version_file.read.gsub(StructuredChangelog::VersionPattern, changelog.version.to_s))

  puts "Updated gem version to #{changelog.version}"
end
