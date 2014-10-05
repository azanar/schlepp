module Schlepp
  class Sink
    class TableObject
      class Chunker
        class Template
          def initialize(model, prefix, template, opts = {})
            @model = model
            @prefix = prefix
            @template = template
          end

          def file_for_chunk(chunk)
            basename = @template % chunk
            uri = @prefix.merge(basename)
            Hydrogen::TableObject.new(@model, uri)
          end
        end
      end
    end
  end
end
