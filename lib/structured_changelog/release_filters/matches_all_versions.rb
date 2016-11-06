require 'structured_changelog/release_filters/base'

class StructuredChangelog
  module ReleaseFilters
    class MatchesAllVersions < Base
      def self.pattern
        /^all$/
      end

      def filter_releases(releases)
        releases
      end
    end
  end
end
