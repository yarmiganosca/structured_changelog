require 'structured_changelog/release_filters/base'
require 'structured_changelog/version_pattern'

class StructuredChangelog
  module ReleaseFilters
    class MatchesSingleVersion < Base
      def self.pattern
        /^#{VersionPattern}$/
      end

      def filter_releases(releases)
        releases.select do |release|
          release.version == query
        end
      end
    end
  end
end
