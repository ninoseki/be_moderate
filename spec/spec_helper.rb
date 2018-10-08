# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

require 'dotenv/load'
require 'mocha'
require 'rack/test'
require 'rspec'
require 'sinatra'
require 'vcr'
require 'zlib'

require_relative '../app/main'
require_relative '../lib/miopon'

RSpec.configure do |config|
  config.mock_with :mocha
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # comma-separeted IIJMIO identifiers (e.g. hdo000000000)
  words = ENV["IIJMIO_IDENTIFIERS"].to_s.split(",")
  words += %w(IIJMIO_DEVELOPER_ID IIJMIO_AUTHORIZATION PUSHBULLET_API_KEY PUSHBULLET_IDENTIFIER).map { |k| ENV[k] }
  words.each do |w|
    config.filter_sensitive_data("<CENSORED/>") { w }
  end

  config.before_record do |i|
    # i.response.body = Zlib::GzipReader.new(StringIO.new(i.response.body), encoding: 'ASCII-8BIT').read
    i.response.body.force_encoding('UTF-8')
  end
end
