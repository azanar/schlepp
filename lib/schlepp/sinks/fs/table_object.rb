module Schlepp
  module Sink
    module Fs
      class TableObject
        def initialize(table_object, root, opts = {})
          @table_object = table_object
          @root = root
        end

        def url
          root = URI("file:///#{@root}/")
          suf = @table_object.url

          root.merge(suf)
        end
      end
    end
  end
end
