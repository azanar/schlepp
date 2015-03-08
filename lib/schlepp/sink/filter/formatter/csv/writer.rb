require 'csv'

module Schlepp
  class Sink 
    module Filter
      module Formatter
        class Csv
          class Writer
            def initialize(writer, opts = {})
              @writer = writer
            end

            def write(rows)
              @writer.write(rows.to_csv)
            end

            def rotate?
              false
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
