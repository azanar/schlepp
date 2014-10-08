require 'schlepp/sink/filter'
require 'schlepp/sink/table_object/formatter/csv/writer'

module Schlepp
  class Sink
    module Filter
      class Csv
        include Schlepp::Sink::Filter::Static
        def extension
          'csv'
        end

        def writer
          Schlepp::Sink::TableObject::Formatter::Csv::Writer
        end
      end
    end
  end
end


