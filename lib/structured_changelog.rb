require 'pathname'

class StructuredChangelog
  attr_reader :path

  def initialize(path)
    @path = Pathname.new(path)
  end

  def version
    line = path.readlines.find { |line| line.start_with?("## RELEASE") }

    line.match(pattern)[:version]
  end

  private

  def pattern
    /^## RELEASE (?<version>\d+\.\d+\.\d+)$/
  end
end
