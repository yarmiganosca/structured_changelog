require 'structured_changelog/release_comparators/base'

class StructuredChangelog
  module ReleaseComparators
    class MatchesVersionsLessThanOrEqualTo < Base
      def self.pattern
        /^\<(?<version>\d+\.\d+\.\d+)$/
      end

      def call(release)
        release.version <= version
      end

      private

      def version
        query.match(self.class.pattern)[:version]
      end
    end
  end
end
