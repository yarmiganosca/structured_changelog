require 'structured_changelog'
require 'git'

desc 'Commit changes to the Changelog & version files as necessary'
task 'changelog:commit', [:repo_path, :changelog_path, :version_path] do |_task, arguments|
  repo_path      = arguments.to_h.fetch(:repo_path)      { Pathname.pwd }
  changelog_path = arguments.to_h.fetch(:changelog_path) { "CHANGELOG.md" }
  version_path   = arguments.to_h.fetch(:version_path)   { "lib/#{Pathname.pwd.basename}/version.rb"}

  changelog = StructuredChangelog.new(changelog_path)
  repo      = Git.open(repo_path)

  if repo.status.deleted.any?
    abort "Please commit all file deletions before bumping the version."
  end

  if repo.status.added.any?
    abort "Please commit all new files before bumping the version."
  end

  if repo.status.changed.keys.sort != [changelog_path, version_path].sort
    abort "Please commit all files that aren't #{changelog_path} or #{version_path} before bumping the version."
  end

  repo.add([changelog_path, version_path])
  repo.commit("Version bump to #{changelog.version}")

  puts "Commited 'Version bumpd to #{changelog.version}'"
end
