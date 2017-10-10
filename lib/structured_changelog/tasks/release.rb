desc "Validates your Changelog, updates your VERSION constant, commits that, then releases your gem."
task 'changelog:release', [:repo_path, :changelog_path, :version_path] do |_task, arguments|
  Rake::Task['changelog:prep'].execute(arguments)

  # Merely requiring `bundler/gem_tasks` instantiates & caches a gemspec. At this point in this code,
  # it's already set and attached to the `Bundler::GemHelper` module. In fact, it's there before this
  # file is laoded at all. This means that our changes to the filesystem won't change the version bundler
  # thinks our gem is. We could instantiate another gemspec and attach it, or we could try modifying the
  # gemspec in situ, but both would be extremely brittle. What we do instead, is start another process,
  # and because that process doesn't have the state ours does already, our changes to the filesystem will
  # be picked up, and we'll actually cut a release of the new version.
  exec('rake release')
end
