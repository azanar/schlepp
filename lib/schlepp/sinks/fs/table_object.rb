module Schlepp
  module Sink
    module Fs
      class TableObject
        def initialize(table_object, opts = {})
          @table_object = table_object
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

        def file
          @file ||= File.new("/tmp/#{@table_object.path}", 'w')
        end
      end
    end
  end
end
