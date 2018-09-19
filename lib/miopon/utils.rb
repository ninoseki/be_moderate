# frozen_string_literal: true

require 'rollbar'

module Miopon
  module Utils
    Rollbar.configure do |config|
      config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]
    end

    def with_error_notify
      yield
    rescue RestClient::ExceptionWithResponse => e
      s = [e.message, e.response].join(" : ")
      Rollbar.error s
    end
  end
end
