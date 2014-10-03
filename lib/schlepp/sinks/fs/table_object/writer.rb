module Schlepp
  module Sink
    module Fs
      class TableObject
        class Writer
          def initialize(table_object, opts = {})
            @table_object = table_object
            @written = 0
          end

          def file
            @file ||= File.new("#{@table_object.url.path}", 'w')
          end

          def write(rows)
            Array(rows).each do |row|
              @written += row.length
              file.write(row)
            end
          end

          def written
            @written
          end

          def finalize
            @file.close
          end
        end
      end
    end
  end
end
