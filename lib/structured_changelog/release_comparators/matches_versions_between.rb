require 'structured_changelog/release_comparators/base'

class StructuredChangelog
  module ReleaseComparators
    class MatchesVersionsBetween < Base
      def self.pattern
        /^(?<floor>\d+\.\d+\.\d+)\<(?<ceiling>\d+\.\d+\.\d+)$/
      end

      def call(release)
        floor < release.version && release.version < ceiling
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
