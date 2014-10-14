module Schlepp
  class Sink
    class TableObject
      class Filter
        class Writer
          def initialize(writer, observer, opts = {})
            @writer = writer
            @observer = observer
          end

          def write(rows)
            Array(rows).each do |row|
              @writer.write(row)
              @observer.add(row)
            end
          end

          def finalize
            @writer.finalize
            @observer.reset
          end
        end
      end
    end
  end
end
