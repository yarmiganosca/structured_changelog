class StructuredChangelog
  class Roadmap
    def self.pattern
      /^## ROADMAP (?<version>\d+\.\d+\.\d+)$/
    end

    def <=>(roadmap)
      version <=> roadmap.version
    end

    def initialize(contents)
      @contents = contents
    end

    def version
      contents.match(self.class.pattern)[:version]
    end

    private

    attr_reader :contents
  end
end
