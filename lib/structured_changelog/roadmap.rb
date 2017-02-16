require 'structured_changelog/version_pattern'

class StructuredChangelog
  class Roadmap
    def self.start_with?(line)
      patterns.any? { |pattern| line =~ pattern }
    end

    def self.patterns
      [
        /^## ROADMAP #{VersionPattern}$/,
        /^## ROADMAP/,
        /^## NEXT RELEASE/,
      ]
    end

    def <=>(roadmap)
      version <=> roadmap.version
    end

    def initialize(contents)
      @contents = contents.strip
    end

    def version
      self.class.patterns.each do |pattern|
        match = contents.match(pattern)

        if match && match.names.include?('version')
          return Gem::Version.new(match[:version])
        end
      end

      Gem::Version.new(nil)
    end

    private

    attr_reader :contents
  end
end
