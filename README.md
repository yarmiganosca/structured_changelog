# StructuredChangelog

You have a changelog in your repo, right? Great! Then what do you need with a `VERSION` constant?

To parse your gem's current version from your changelog, put this in `lib/myproject/version.rb`:

```ruby
require 'structured_changelog'

MyProject::VERSION = StructuredChangeog.new("path/to/CHANGELOG.md").version
```

If you use `rake release` to release new code, & want changelog validation to be a part of that release task, you can add this to your `Rakefile`:

```ruby
require 'structured_changelog/tasks'
```

(This will execute code that injects the `changelog:validate` task into the list of tasks `rake release` runs before performing a release.)

You'll also get these other wonderful rake tasks:

## Wonderful Rake Tasks

To validate your changelog:

    $ rake changelog:validate

To determine what version you're on:

    $ rake changelog:version

To view the release notes of the current release:

    $ rake changelog:notes
    $ rake changelog:notes[current]
    
To view the release notes of every release:

    $ rake changelog:notes[all]

for a specific release:

    $ rake changelog:notes[1.0.4]

for all releases inclusively after a given release:

    $ rake changelog:notes[1.0.4<]

for all releases inclusively before a given release:

    $ rake changelog:notes[<2.0.4]

for all releases inclusively between two releases:

    $ rake changelog:notes[1.0.4<2.0.4]

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

