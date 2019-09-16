require 'structured_changelog/core_ext/gem/version'
require 'structured_changelog/core_ext/string'

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
      @release_notes ||= git_log_since_last_release
        .split("\n")
        .map(&:strip)
        .grep(/#{optional_prefix_pattern}(BREAKING|FEATURE|FIX|ENHANCEMENT|DEPRECATION):\ /)
        .map { |release_line| release_line.sub(optional_prefix_pattern, "* ") }
        .join("\n")
    end

    def optional_prefix_pattern
      /^(\*\ )?/
    end

    def git_log_since_last_release
      repo.chdir do
        `git log v#{current_version}..HEAD`.chomp
      end
    end

    def current_version
      @current_version ||= changelog.version
    end

    def new_version
      @new_version ||= if release_notes.match?(/#{optional_prefix_pattern}BREAKING:\ /)
                         current_version.bump_major
                       elsif release_notes.match?(/#{optional_prefix_pattern}FEATURE:\ /)
                         current_version.bump_minor
                       elsif release_notes.match?(/#{optional_prefix_pattern}FIX:\ /)
                         current_version.bump_patch
                       elsif release_notes.match?(/#{optional_prefix_pattern}ENHANCEMENT:\ /)
                         current_version.bump_patch
                       elsif release_notes.match?(/#{optional_prefix_pattern}DEPRECATION:\ /)
                         current_version.bump_patch
                       end
    end
  end
end
