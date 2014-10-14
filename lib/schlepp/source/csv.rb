require 'csv'

require 'schlepp/source'

module Schlepp
  module Source
    class CSV
      def initialize(fp)
        @csv = ::CSV.new(fp, {:headers => true})

        @csv.shift
      end

      def columns
        @csv.headers
      end

      def each
        @csv.each do |r|
          yield [r.fields]
        end
      end
    end
  end
end

