require 'structured_changelog/release_comparators/base'

class StructuredChangelog
  module ReleaseComparators
    class MatchesVersionsGreaterThanOrEqualTo < Base
      def self.pattern
        /^(?<version>\d+\.\d+\.\d+)\<$/
      end

      def call(release)
        version <= release.version
      end

      private

      def version
        query.match(self.class.pattern)[:version]
      end
    end
  end
end
