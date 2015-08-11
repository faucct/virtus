module Virtus
  class Attribute
    module CollectionAccessor
      def get(instance)
        Array.new(super).tap do |collection|
          collection.instance_variable_set('@member_type', member_type)
        end
      end

      class Array < ::Array
        def <<(value)
          if value.kind_of? ::Hash
            super @member_type.coerce value
          else
            super
          end
        end
      end
    end
  end
end
