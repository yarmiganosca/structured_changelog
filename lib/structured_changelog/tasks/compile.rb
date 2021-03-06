require 'git'

require 'structured_changelog'
require 'structured_changelog/release_preview'

desc "Pull all release lines from git commits since the last release and insert them into a release section in the changelog"
task "changelog:compile", [:repo_path, :changelog_path] do |_task, arguments|
  repo_path      = arguments.to_h.fetch(:repo_path)      { Pathname.pwd }
  changelog_path = arguments.to_h.fetch(:changelog_path) { Pathname.pwd/"CHANGELOG.md" }

  changelog = StructuredChangelog.new(changelog_path)

  release_preview = StructuredChangelog::ReleasePreview.new(
    changelog: changelog,
    repo:      Git.open(repo_path),
  )

  abort("No release notes since the last release") if release_preview.empty?

  changelog_path.write(
    changelog_path.read.sub(
      /^##\ RELEASE\ #{changelog.version}/,
      "#{release_preview}\n\n## RELEASE #{changelog.version}"
    )
  )
end
