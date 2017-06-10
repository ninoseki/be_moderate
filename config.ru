require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'

get '/' do
  "Be Moderate"
end

run Sinatra::Application
