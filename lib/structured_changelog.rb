require 'pathname'

class StructuredChangelog
  attr_reader :path

  def initialize(path)
    @path = Pathname.new(path)
  end

  def version
    line = path.readlines.find { |line| line.start_with?("## RELEASE") }

    line.match(version_pattern)[:version]
  end

  def roadmap_versions
    lines = path.readlines.select { |line| line.start_with?("## ROADMAP") }

    lines.reverse.map { |line| line.match(roadmap_pattern)[:version] }
  end

  private

  def version_pattern
    /^## RELEASE (?<version>\d+\.\d+\.\d+)$/
  end

  def roadmap_pattern
    /^## ROADMAP (?<version>\d+\.\d+\.\d+)$/
  end
end
