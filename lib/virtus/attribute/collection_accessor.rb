module Virtus
  class Attribute
    module CollectionAccessor
      def self.extended(descendant)
        primitive = Class.new(descendant.primitive)
        member_type = descendant.member_type
        primitive.send(:define_method, :coerce) { |value| member_type.coerce value }
        primitive.include(CoercibleCollection)
        descendant.instance_variable_set('@primitive', primitive)
      end

      module CoercibleCollection
        def <<(value)
          super(coerce value)
        end

        def []=(key, value)
          super(key, coerce(value))
        end
      end
    end
  end
end
