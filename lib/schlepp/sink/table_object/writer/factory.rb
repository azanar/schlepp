module Schlepp
  class Sink
    class TableObject
      class Writer
        class Factory
          def initialize(factory, components, table_object)
            @factory = factory
            @components = components
            @table_object = table_object
          end

          def new
            writer = @factory.writer(@table_object)
            @components.reverse.inject(writer) {|base, f|
              f.writer.new(base)
            }
          end
        end
      end
    end
  end
end
