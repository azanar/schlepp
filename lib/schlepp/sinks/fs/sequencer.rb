require 'schlepp/sink/sequencer'
require 'schlepp/sinks/fs/chunker'
require 'schlepp/sinks/fs/table_object/collection'

module Schlepp
  module Sink
    module Fs
      class Sequencer
        include Schlepp::Sink::Sequencer

        def collection
          Schlepp::Sink::Fs::TableObject::Collection
        end

        def chunker
          Schlepp::Sink::Fs::Chunker
        end
      end
    end
  end
end
