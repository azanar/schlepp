module Schlepp
  class Sink
    class TableObject
      class Filter
        class Observer
          def initialize
            reset
          end

          attr_reader :count

          def add(data)
            @count += data.length
          end

          def reset
            @count = 0
          end
        end
      end
    end
  end
end
