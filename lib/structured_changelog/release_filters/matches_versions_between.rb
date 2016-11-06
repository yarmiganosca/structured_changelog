require 'structured_changelog/release_filters/base'

class StructuredChangelog
  module ReleaseFilters
    class MatchesVersionsBetween < Base
      def self.pattern
        /^(?<floor>\d+\.\d+\.\d+)\<(?<ceiling>\d+\.\d+\.\d+)$/
      end

      def filter_releases(releases)
        releases.select do |release|
          floor <= release.version && release.version <= ceiling
        end
      end

      private

      def floor
        query.match(self.class.pattern)[:floor]
      end

      def ceiling
        query.match(self.class.pattern)[:ceiling]
      end
    end
  end
end
