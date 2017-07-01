require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'

require_relative './app/main'

$stdout.sync = true

run Sinatra::Application
