require 'structured_changelog'
require 'git'

desc 'Commit changes to the Changelog & version files as necessary'
task 'changelog:commit', [:repo_path, :changelog_path, :version_path] do |_task, arguments|
  repo_path      = arguments.to_h.fetch(:repo_path)      { Pathname.pwd }
  changelog_path = arguments.to_h.fetch(:changelog_path) { "CHANGELOG.md" }
  version_path   = arguments.to_h.fetch(:version_path)   { "lib/#{Pathname.pwd.basename}/version.rb" }

  changelog = StructuredChangelog.new(changelog_path)
  git       = Git.open(repo_path)

  if git.status.deleted.any?
    abort "Please commit all file deletions before bumping the version."
  end

  if git.status.added.any?
    abort "Please commit all new files before bumping the version."
  end

  diff = git.diff('HEAD').stats[:files]

  only_release_changes      = diff.keys.sort == [changelog_path, version_path, 'Gemfile.lock'].sort
  lock_only_changed_version = diff['Gemfile.lock'].deletions == 1 && diff['Gemfile.lock'].insertions == 1

  unless only_release_changes
    abort "Please commit all files that aren't #{acceptable_changes.join(' or ')} before bumping the version."
  end

  unless lock_only_changed_version
    abort "Please commit all Gemfile.lock changes not related to this version bump."
  end

  git.add([changelog_path, version_path, 'Gemfile.lock'])
  git.commit("Version bump to #{changelog.version}")

  puts "Commited 'Version bumped to #{changelog.version}'"
end
