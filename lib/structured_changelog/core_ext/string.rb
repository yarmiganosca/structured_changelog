class StructuredChangelog
  module CoreExt
    module String
      def match?(*args)
        !!match(*args)
      end
    end
  end
end

String.send(:include, StructuredChangelog::CoreExt::String) unless "".respond_to?(:match?)
