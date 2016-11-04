require 'structured_changelog/release_comparators/base'

class StructuredChangelog
  module ReleaseComparators
    class MatchesAllVersions < Base
      def self.pattern
        /^ALL$/
      end

      def call(release)
        true
      end
    end
  end
end
