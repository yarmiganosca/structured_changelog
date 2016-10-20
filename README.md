# StructuredChangelog

You have a changelog in your repo, right? Great! Then what do you need with a `VERSION` constant?

To parse your gem's current version right off your changelog, put this in `yourproject.gemspec`:

```ruby
require 'structured_changelog'

Gem::Specification.new do |spec|
  ...
  spec.version = StructuredChangeog.new("path/to/CHANGELOG.md").version
  ...
end
```

To add `rake structured_changelog:validate` and make it part of `rake release`, add this to your `Rakefile`:

```ruby
require 'structured_changelog/tasks'
```




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

