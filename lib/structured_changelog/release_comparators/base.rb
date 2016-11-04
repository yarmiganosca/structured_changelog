class StructuredChangelog
  module ReleaseComparators
    class Base
      def self.appropriate_for_query?(query)
        !query.match(pattern).nil?
      end

      def initialize(query)
        @query = query
      end

      def to_proc
        method(:call).to_proc
      end

      private

      attr_reader :query
    end
  end
end
