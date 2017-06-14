ENV['RACK_ENV'] = 'test'
require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'
require 'vcr'

require 'sinatra'
require_relative '../app/main'
require_relative '../lib/miopon'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

ENV["IIJMIO_DEVELOPER_ID"] = "xxx"
ENV["IIJMIO_AUTHORIZATION"] = "xxx"
