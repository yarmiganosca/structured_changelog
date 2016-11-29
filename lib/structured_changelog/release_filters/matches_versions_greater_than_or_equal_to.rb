require 'structured_changelog/release_filters/base'

class StructuredChangelog
  module ReleaseFilters
    class MatchesVersionsGreaterThanOrEqualTo < Base
      def self.pattern
        /^(?<version>\d+\.\d+\.\d+\S*)\ \<$/
      end

      def filter_releases(releases)
        releases.select do |release| 
          version <= release.version
        end
      end

      private

      def version
        query.match(self.class.pattern)[:version]
      end
    end
  end
end
