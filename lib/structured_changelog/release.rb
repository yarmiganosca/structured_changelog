class StructuredChangelog
  class Release
    def self.pattern
      /^## RELEASE (?<version>\d+\.\d+\.\d+)$/
    end

    def <=>(release)
      version <=> release.version
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
