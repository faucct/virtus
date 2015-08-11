module Virtus
  class Attribute
    module CollectionAccessor
      @@collections = {}
      @@mutex = Mutex.new

      def get(instance)
        value = super
        @@mutex.synchronize do
          @@collections[value.class] ||= Class.new(value.class).tap { |klass| klass.include(CoercibleCollection) }
        end.new(value).tap do |collection|
          collection.instance_variable_set('@member_type', member_type)
        end
      end

      module CoercibleCollection
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
