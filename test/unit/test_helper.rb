require 'coveralls'

if ENV["ENABLE_SIMPLE_COV"]
  require 'simplecov'
  SimpleCov.start do
    add_group "Lib", "lib"
    add_filter "/test/"
    command_name "Unit Tests"
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  end
end

require 'test/unit'

ENV["QUASAR_ENV"] = "test"

require 'mocha/setup'

module TestHelper
end
