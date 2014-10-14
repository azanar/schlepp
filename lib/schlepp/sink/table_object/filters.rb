module Schlepp
  class Sink
    class TableObject
      class Filters
        def initialize
          @filters = []
        end

        def add(filter)
          @filters << filter
        end

        def decorate(writer)
          @filters.reverse.inject(writer) do |base, f| 
            f.decorate(base) 
          end
        end
      end
    end
  end
end

