require 'coveralls'
Coveralls.wear!

if ENV["ENABLE_SIMPLE_COV"]
  require 'simplecov'
  require File.expand_path('../../simplecov_helper', __FILE__)
  SimpleCov.start 'pocketchange'
end

require 'test/unit'

ENV["QUASAR_ENV"] = "test"

require 'mocha/setup'
require 'aws'

module TestHelper
  AWS.config(
    :access_key_id => 'ACCESS_KEY_ID',
    :secret_access_key => 'SECRET_ACCESS_KEY',
    :stub_requests => true
  )
end
