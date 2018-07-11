# StructuredChangelog

You have a changelog in your repo, right? Great! Then you'll never need to manually update your `VERSION` constant again!

Add this to your Rakefile:

```ruby
require 'structured_changelog/tasks'
```

## With A Single Contributor

If you have a single-contributor project, you can simply add release lines to `CHANGELOG.md`:

```
* FEATURE: we added a new thing
* FIX: we fixed a broken thing
```

then when you want to cut a release, add a `"## RELEASE X.Y.Z"` section, making the above look like:

```
## RELEASE X.Y.Z

* FEATURE: we added a new thing
* FIX: we fixed a broken thing
```

and run

    $ rake changelog:release

This will:

1. validate your `CHANGELOG.md`
2. set your gem's `VERSION` constant to the latest release version specified by your `CHANGELOG.md`
3. commit that version bump
4. package your gem and push it to the specified gem server (rubygems.org by default)

## With Multiple Contributors

If you have multiple contributors, and you follow the single-contributor workflow, you'll end up with conflicts every time multiple people go to add a line to the changelog. We have a separate workflow for you.

When you want to add release notes, instead of adding them directly to the changelog, add them to any git commit:

```
Describe what I did this commit

More description goes here

* FIX: we fixed a thing that was broken
```

Any line in a commit message that starts with `* BREAKING: `, `* FEATURE: `, `* FIX: `, `* ENHANCEMENT: `, or `* DEPRECATION: ` will be included in the release notes for the next version.

Then, when you're ready to cut a release, run:

    $ rake changelog:compile
    
This will pull all the release lines you've written in git commit messages since the last release from the commit log, and create a new release section in your changelog. It will have the minimum version possible given the change types (BREAKING is a major bump, FEATURE is a minor bump, and FIX, ENHANCEMENT, and DEPRECATION are all patch bumps). Once the rake task has written the new section to the changelog, it's often beneficial to give it a look and make sure it's free of typos and any other mistakes. Then, run

    $ rake changelog:release

as usual to actually release your gem.

## Viewing Release Notes

To view the release notes of the current release:

    $ rake changelog:notes
    $ rake changelog:notes[current]

To view the release notes of every release:

    $ rake changelog:notes[all]

for a specific release:

    $ rake changelog:notes[1.0.4]

for all releases inclusively after a given release:

    $ rake changelog:notes[1.0.4 <]

for all releases inclusively before a given release:

    $ rake changelog:notes[< 2.0.4]

for all releases inclusively between two releases:

    $ rake changelog:notes[1.0.4 < 2.0.4]

To view the last 3 releases:

    $ rake changelog:recent

To view the last N releases:

    $ rake changelog:recent[N]

## Other Rake Tasks

To determine the version of the latest release *according to the Changelog*:

    $ rake changelog:version

To validate your changelog:

    $ rake changelog:validate
    
To update your gem's `VERSION` constant to the latest release in your Changelog:

    $ rake changelog:sync

To commit your version bump--and only your version bump:

    $ rake changelog:commit

To do everything but release your code (so that it can go through a PR for CI, for instance):

    $ rake changelog:prep

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'structured_changelog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install structured_changelog

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yarmiganosca/structured_changelog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

