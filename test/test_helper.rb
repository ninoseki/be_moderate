ENV['RACK_ENV'] = 'test'
require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'

require 'sinatra'
require_relative '../app/main'
