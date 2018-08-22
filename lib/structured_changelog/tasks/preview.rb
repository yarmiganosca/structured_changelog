require 'git'

require 'structured_changelog'
require 'structured_changelog/release_preview'

desc "View the release section changelog:compile would insert into the changelog without actually doing so"
task 'changelog:preview', [:repo_path, :changelog_path] do |_task, arguments|
  repo_path      = arguments.to_h.fetch(:repo_path)      { Pathname.pwd }
  changelog_path = arguments.to_h.fetch(:changelog_path) { Pathname.pwd/"CHANGELOG.md" }

  changelog = StructuredChangelog.new(changelog_path)

  release_preview = StructuredChangelog::ReleasePreview.new(
    changelog: changelog,
    repo:      Git.open(repo_path),
  )

  abort("No release notes since the last release") if release_preview.empty?

  puts release_preview.to_s
end
