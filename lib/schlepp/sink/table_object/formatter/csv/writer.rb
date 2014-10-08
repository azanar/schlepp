require 'csv'

module Schlepp
  class Sink 
    class TableObject
      class Formatter
        class Csv
          class Writer
            def initialize(writer, opts = {})
              @writer = writer
            end

            def write(rows)
              @writer.write(rows.to_csv)
            end

            def finalize
              @writer.finalize
            end
          end
        end
      end
    end
  end
end
