require 'pathname'
require 'structured_changelog/release'
require 'structured_changelog/roadmap'
require 'structured_changelog/release_filters'

class StructuredChangelog
  attr_reader :path, :releases, :roadmaps

  def initialize(path)
    @path = Pathname.new(path)

    @releases = Set.new([])
    @roadmaps = Set.new([])

    parse
  end

  def version
    latest_release.version
  end

  def validate
    notifications = []

    if latest_release.nil?
      notifications << "No RELEASE blocks"
    else
      notifications += latest_release.validate
    end

    notifications.each(&method(:puts))

    notifications.empty?
  end

  def find_releases(query)
    ReleaseFilters
      .filter_for(query)
      .filter_releases(releases)
  end

  private

  def latest_release
    releases.max
  end

  def parse
    capture = []

    [*path.readlines, :EOF].each do |line|
      if line == :EOF || Roadmap.start_with?(line) || Release.start_with?(line)
        if Roadmap.start_with?(capture.first)
          roadmaps << Roadmap.new(capture.join)
          capture = []
        elsif Release.start_with?(capture.first)
          releases << Release.new(capture.join)
          capture = []
        end
      end

      capture << line
    end

    self
  end
end
