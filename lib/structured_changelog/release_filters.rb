Dir[File.join(File.dirname(__FILE__), "release_filters", "*.rb")].each(&method(:require))

class StructuredChangelog
  class IllegalQuery < StandardError; end

  module ReleaseFilters
    def self.filter_for(query)
      filter_class = filter_class_for_query(query)

      raise IllegalQuery.new(query) unless filter_class

      filter_class.new(query)
    end

    def self.filter_class_for_query(query)
      filter_classes.find do |filter_class|
        filter_class.appropriate_for_query?(query)
      end
    end

    def self.filter_classes
      [
        MatchesCurrentVersion,
        MatchesAllVersions,
        MatchesSingleVersion,
        MatchesVersionsGreaterThanOrEqualTo,
        MatchesVersionsLessThanOrEqualTo,
        MatchesVersionsBetween
      ]
    end
  end
end
