require 'schlepp/sink/filter'
require 'schlepp/sink/filter/formatter/csv/writer'

module Schlepp
  class Sink
    module Filter
      module Formatter
        class Csv
          include Schlepp::Sink::Filter::Static
          def extension
            'csv'
          end

          def writer
            Schlepp::Sink::Filter::Formatter::Csv::Writer
          end
        end
      end
    end
  end
end

