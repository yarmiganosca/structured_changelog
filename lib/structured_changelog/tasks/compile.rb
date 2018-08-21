require 'structured_changelog'
require 'structured_changelog/core_ext/string'
require 'structured_changelog/core_ext/gem'
require 'git'

desc "Pull all release lines from git commits since the last release and insert them into a release section in the CHANGELOG"
task "changelog:compile", [:repo_path, :changelog_path] do |_task, arguments|
  repo_path      = arguments.to_h.fetch(:repo_path)      { Pathname.pwd }
  changelog_path = arguments.to_h.fetch(:changelog_path) { Pathname.pwd/"CHANGELOG.md" }

  current_version = StructuredChangelog.new(changelog_path).version

  repo = Git.open(repo_path)

  release_notes = repo.log.between("v#{current_version}").
    map(&:message).
    flat_map { |message| message.split("\n") }.
    grep(/^\*\ (BREAKING|FEATURE|ENHANCEMENT|FIX|DEPRECATION)\:/).
    map(&:strip).
    join("\n")

  abort("No release notes since the last release") if release_notes.empty?

  new_version = if release_notes.match?(/^*\ BREAKING:/)
                  current_version.bump_major
                elsif release_notes.match?(/^*\ FEATURE:/)
                  current_version.bump_minor
                elsif release_notes.match?(/^*\ FIX:/)
                  current_version.bump_patch
                elsif release_notes.match?(/^*\ ENHANCEMENT:/)
                  current_version.bump_patch
                elsif release_notes.match?(/^*\ DEPRECATION:/)
                  current_version.bump_patch
                end

  changelog_path.write(
    changelog_path.read.sub(
      /^##\ RELEASE\ #{current_version}/,
      "## RELEASE #{new_version}\n\n#{release_notes}\n\n## RELEASE #{current_version}"
    )
  )
end
