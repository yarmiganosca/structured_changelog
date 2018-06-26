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
      unbumped_segments = segments[0...index]
      bumped_segment    = [segments[index] + 1]
      # zero out the remaining segments until we hit a non-numeric (rc, say) segment
      trailing_zeroes   = [0] * segments[(index + 1)..-1].take_while { |x| x.is_a?(Fixnum) }.size

      bumped_segments =
        unbumped_segments +
        bumped_segment +
        trailing_zeroes

      self.class.new(bumped_segments.join('.'))
    end
  end
end

Gem::Version.send(:include, StructuredChangelog::VersionInstanceMethods)
