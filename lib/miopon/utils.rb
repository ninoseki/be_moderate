require 'rollbar'

module Miopon
  module Utils

    Rollbar.configure do |config|
      config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]
    end
    
    def with_error_notify
      yield
    rescue => e
      Rollbar.error e.to_s
    end
  end
end
