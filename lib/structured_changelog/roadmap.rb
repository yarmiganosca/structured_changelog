class StructuredChangelog
  class Roadmap
    def self.start_with?(line)
      patterns.any? { |pattern| line =~ pattern }
    end

    def self.patterns
      [
        /^## ROADMAP (?<version>\S+)$/,
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

        return match[:version] if match && match.names.include?('version')
      end

      nil
    end

    private

    attr_reader :contents
  end
end
