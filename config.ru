require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'

require_relative './app/main'

run Sinatra::Application
