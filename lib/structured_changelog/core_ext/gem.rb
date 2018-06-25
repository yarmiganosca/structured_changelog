class StructuredChangelog
  module VersionInstanceMethods
    def bump_major
      bump_at_segment_index(0)
    end

    def bump_minor
      bump_at_segment_index(1)
    end

    def bump_patch
      bump_at_segment_index(2)
    end

    private

    def bump_at_segment_index(index)
      bumped_segments = segments
      bumped_segments[index] += 1

      self.class.new(bumped_segments.join("."))
    end
  end
end

Gem::Version.send(:include, StructuredChangelog::VersionInstanceMethods)
