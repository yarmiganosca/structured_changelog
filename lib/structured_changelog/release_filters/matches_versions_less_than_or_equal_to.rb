require 'structured_changelog/release_filters/base'

class StructuredChangelog
  module ReleaseFilters
    class MatchesVersionsLessThanOrEqualTo < Base
      def self.pattern
        /^\<(?<version>\d+\.\d+\.\d+)$/
      end

      def filter_releases(releases)
        releases.select do |release| 
          release.version <= version
        end
      end

      private

      def version
        query.match(self.class.pattern)[:version]
      end
    end
  end
end
