require 'hydrogen/table_object/collection'

module Schlepp
  module Sink
    module Fs
      class TableObject
        class Collection
          include Hydrogen::TableObject::Collection

          def url
            "file:///#{path}"
          end

          def urls
            parts.map do |p|
              TableObject.new(p).url
            end
          end
        end
      end
    end
  end
end
