require 'hydrogen'

require "schlepp/env"
require "schlepp/sink"
require "schlepp/source/csv"
require "schlepp/version"

module Schlepp
  module_function

  def schlepp(source, sink)
    source.each do |s|
      sink.write(s)
    end
    sink.finalize
  end
end
