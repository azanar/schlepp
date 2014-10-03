module Schlepp
  module Sink
    module Fs
      class TableObject
        def initialize(table_object, opts = {})
          @table_object = table_object
        end

        def url
          URI("file:///tmp/#{@table_object.path}")
        end
      end
    end
  end
end
