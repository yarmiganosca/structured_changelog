# StructuredChangelog

You have a changelog in your repo, right? Great! Then you'll never need to manually update your `VERSION` constant again!

Add this to your Rakefile:

```ruby
require 'structured_changelog/tasks'
```

This will modify the default `rake release` task so that 2 things happen before it:

1. your `CHANGELOG.md` is validated
2. your gem's `VERSION` constant is set to the latest release version specified by your `CHANGELOG.md`

You'll get these other wonderful rake tasks:

## Wonderful Rake Tasks

To validate your changelog:

    $ rake changelog:validate
    
To update your gem's `VERSION` constant to the latest release in your Changelog:

    $ rake changelog:sync

To determine the version of the latest release *according to the Changelog*:

    $ rake changelog:version

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

