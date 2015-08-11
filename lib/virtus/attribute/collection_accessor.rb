module Virtus
  class Attribute
    module CollectionAccessor
      def self.extended(descendant)
        primitive = Class.new(descendant.primitive).tap do |klass|
          klass.include(CoercibleCollection)
          klass.instance_variable_set('@member_type', descendant.member_type)
        end
        descendant.instance_variable_set('@primitive', primitive)
      end

      module CoercibleCollection
        def <<(value)
          super self.class.instance_variable_get('@member_type').coerce value
        end
      end
    end
  end
end
