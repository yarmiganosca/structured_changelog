require 'structured_changelog/release_comparators/base'

class StructuredChangelog
  module ReleaseComparators
    class MatchesSingleVersion < Base
      def self.pattern
        /^\d+\.\d+\.\d+$/
      end

      def call(release)
        release.version == query
      end
    end
  end
end
