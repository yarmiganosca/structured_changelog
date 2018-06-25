class StructuredChangelog
  module StringInstanceMethods
    def match?(*args)
      !!match(*args)
    end
  end
end

String.send(:include, StructuredChangelog::StringInstanceMethods)
