require 'structured_changelog/release_filters/base'
require 'structured_changelog/version_pattern'

class StructuredChangelog
  module ReleaseFilters
    class MatchesVersionsGreaterThanOrEqualTo < Base
      def self.pattern
        /^#{VersionPattern}\ \<$/
      end

      def filter_releases(releases)
        releases.select do |release| 
          Gem::Version.new(version) <= release.version
        end
      end

      private

      def version
        query.match(self.class.pattern)[:version]
      end
    end
  end
end
