require 'schlepp/sink/sequencer'
require 'schlepp/sinks/fs/chunker'

module Schlepp
  module Sink
    module Fs
      class Sequencer
        include Schlepp::Sink::Sequencer

        def chunker
          Schlepp::Sink::Fs::Chunker
        end
      end
    end
  end
end
