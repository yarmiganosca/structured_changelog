require 'structured_changelog/version_pattern'

class StructuredChangelog
  class Release
    attr_reader :contents

    def self.start_with?(line)
      line =~ pattern
    end

    def self.pattern
      /^## RELEASE #{VersionPattern}$/
    end

    def initialize(contents)
      @contents = contents.strip
    end

    def validate
      notifications = []

      notifications << "No version number" if version.nil?

      notifications
    end

    def version
      version_string = contents.match(self.class.pattern)[:version]

      Gem::Version.new(version_string)
    end

    def <=>(release)
      version <=> release.version
    end
  end
end
