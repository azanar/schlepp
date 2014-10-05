require 'schlepp/sink/table_object/chunker/template'

module Schlepp
  class Sink
    class TableObject
      class Chunker
        def initialize(model, root_uri, opts = {})
          @model = model
          @root_uri = root_uri
          @chunk = 0

          @template = Template.new(model, root_uri, "#{model.name}.%i")
          @parts = []
        end

        attr_reader :parts

        def parts
          @parts
        end

        def next
          @chunk += 1
          part = @template.file_for_chunk(@chunk)

          @parts << part

          part
        end
      end
    end
  end
end
