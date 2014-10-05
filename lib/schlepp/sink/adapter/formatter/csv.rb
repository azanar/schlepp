module Schlepp
  class Sink
    module Adapter
      module Formatter
        class Csv
          def initialize(table_object, opts = {})
            @table_object = table_object
          end

          def extension
            'csv'
          end

          def sequence
            chunker.sequence
          end

          def parts
            chunker.parts
          end

          def next
            chunker.next 
          end

          private

          def chunker
            @chunker ||= Schlepp::TableObject::Chunker.new(@table_object)
          end
        end
      end
    end
  end
end
