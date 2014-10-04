module Schlepp
  module Sink
    module Fs
      class Chunker
        class Factory
          def initialize(root)
            @root = root
          end

          def new(table_object)
            Schlepp::Sink::Fs::Chunker.new(table_object, @root)
          end
        end
      end
    end
  end
end
