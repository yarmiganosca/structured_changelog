class StructuredChangelog
  module ReleaseFilters
    class Base
      def self.appropriate_for_query?(query)
        !query.match(pattern).nil?
      end

      def initialize(query)
        @query = query
      end

      private

      attr_reader :query
    end
  end
end
