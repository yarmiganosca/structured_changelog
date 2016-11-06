require 'structured_changelog/release_filters/base'

class StructuredChangelog
  module ReleaseFilters
    class MatchesCurrentVersion < Base
      def self.pattern
        /^current$/
      end

      def filter_releases(releases)
        [releases.max]
      end
    end
  end
end
