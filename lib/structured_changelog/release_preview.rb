require 'structured_changelog/core_ext/string'
require 'structured_changelog/core_ext/gem'

class StructuredChangelog
  class ReleasePreview
    def initialize(changelog:, repo:)
      @changelog = changelog
      @repo      = repo
    end

    def to_s
      "## RELEASE #{new_version}\n\n#{release_notes}"
    end

    def empty?
      release_notes.empty?
    end

    private

    attr_reader :changelog, :repo

    def release_notes
      @release_notes ||= repo.log.between("v#{current_version}").
        map(&:message).
        flat_map { |message| message.split("\n") }.
        grep(/^\*\ (BREAKING|FEATURE|ENHANCEMENT|FIX|DEPRECATION)\:/).
        map(&:strip).
        join("\n")
    end

    def current_version
      @current_version ||= changelog.version
    end

    def new_version
      @new_version ||= if release_notes.match?(/^*\ BREAKING:/)
                         current_version.bump_major
                       elsif release_notes.match?(/^*\ FEATURE:/)
                         current_version.bump_minor
                       elsif release_notes.match?(/^*\ FIX:/)
                         current_version.bump_patch
                       elsif release_notes.match?(/^*\ ENHANCEMENT:/)
                         current_version.bump_patch
                       elsif release_notes.match?(/^*\ DEPRECATION:/)
                         current_version.bump_patch
                       end
    end
  end
end
