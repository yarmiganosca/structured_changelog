class StructuredChangelog
  class Release
    attr_reader :contents

    def self.pattern
      /^## RELEASE (?<version>\d+\.\d+\.\d+)$/
    end

    def initialize(contents)
      @contents = contents
    end

    def validate
      notifications = []

      notifications << "No version number" if version.nil?

      notifications
    end

    def version
      contents.match(self.class.pattern)[:version]
    end

    def <=>(release)
      version <=> release.version
    end
  end
end
