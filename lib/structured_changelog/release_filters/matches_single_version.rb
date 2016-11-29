require 'structured_changelog/release_filters/base'

class StructuredChangelog
  module ReleaseFilters
    class MatchesSingleVersion < Base
      def self.pattern
        /^\d+\.\d+\.\d+\S*$/
      end

      def filter_releases(releases)
        releases.select do |release|
          release.version == query
        end
      end
    end
  end
end
