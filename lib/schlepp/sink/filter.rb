module Schlepp
  class Sink
    module Filter
      module Static
        def should_rotate?
          false
        end

        def rotate
          nil
        end
      end
      module Simple
        def writer
          Schlepp::Sink::TableObject::Writer
        end
      end
    end
  end
end
