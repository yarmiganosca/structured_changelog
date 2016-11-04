Dir[File.join(File.dirname(__FILE__), "release_comparators", "*.rb")].each(&method(:require))

class StructuredChangelog
  IllegalQuery = Class.new(StandardError)

  module ReleaseComparators
    def self.comparator_for(query)
      comparator_class = comparator_class_for_query(query)

      raise IllegalQuery.new(query) unless comparator_class

      comparator_class.new(query)
    end

    def self.comparator_class_for_query(query)
      comparator_classes.find do |comparator_class|
        comparator_class.appropriate_for_query?(query)
      end
    end

    def self.comparator_classes
      [
        MatchesAllVersions,
        MatchesSingleVersion,
        MatchesVersionsGreaterThanOrEqualTo,
        MatchesVersionsLessThanOrEqualTo,
        MatchesVersionsBetween
      ]
    end
  end
end
