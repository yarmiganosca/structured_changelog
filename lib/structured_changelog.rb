require 'pathname'
require 'structured_changelog/release'
require 'structured_changelog/roadmap'

class StructuredChangelog
  attr_reader :path, :releases, :roadmaps

  def initialize(path)
    @path = Pathname.new(path)

    @releases = Set.new([])
    @roadmaps = Set.new([])

    parse
  end

  def version
    releases.max.version
  end

  private

  def parse
    capture = []

    [*path.readlines, :EOF].each do |line|
      if line == :EOF || line =~ Roadmap.pattern || line =~ Release.pattern
        if capture.first =~ Roadmap.pattern
          roadmaps << Roadmap.new(capture.join)
          capture = []
        elsif capture.first =~ Release.pattern
          releases << Release.new(capture.join)
          capture = []
        end
      end

      capture << line
    end

    self
  end
end
