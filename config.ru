require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
require 'sinatra/reloader' if development?

$stdout.sync = true
