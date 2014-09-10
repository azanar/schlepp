require 'hydrogen'

require "schlepp/env"
require "schlepp/source/csv"
require "schlepp/version"

module Schlepp
  module_function

  def schlepp(source, sink)
    source.each do |s|
      sink.write(s)
    end
    sink.finalize
    sink.sequence
  end
end
