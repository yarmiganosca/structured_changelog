require 'structured_changelog'
require 'structured_changelog/core_ext/string'
require 'structured_changelog/core_ext/gem'
require 'git'

task "changelog:compile", [:repo_path, :changelog_path] do |_task, arguments|
  repo_path      = arguments.to_h.fetch(:repo_path)      { Pathname.pwd }
  changelog_path = arguments.to_h.fetch(:changelog_path) { Pathname.pwd/"CHANGELOG.md" }

  current_version = StructuredChangelog.new(changelog_path).version

  repo = Git.open(repo_path)

  commit_messages = repo.log.since("v#{current_version}").map(&:message).select do |message|
    message.match?(/^\[CHANGELOG\]\n\n\*\ /)
  end

  abort("No [CHANGELOG] commits since the last release") if commit_messages.empty?

  message = commit_messages.flat_map do |message|
    message.sub(/^\[CHANGELOG\]\n\n/, "")
  end.join("\n")

  new_version = if message.match?(/^*\ BREAKING:/)
                  current_version.bump_major
                elsif message.match?(/^*\ FEATURE:/)
                  current_version.bump_minor
                elsif message.match?(/^*\ FIX:/)
                  current_version.bump_patch
                elsif message.match?(/^*\ ENHANCEMENT:/)
                  current_version.bump_patch
                elsif message.match?(/^*\ DEPRECATION:/)
                  current_version.bump_patch
                end

  changelog_path.write(
    changelog_path.read.sub(
      /^##\ RELEASE\ #{current_version}/,
      "## RELEASE #{new_version}\n\n#{message}\n\n## RELEASE #{current_version}"
    )
  )
end
