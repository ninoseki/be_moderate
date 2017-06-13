module Miopon
  class Monitor
    attr_reader :client
    def initialize
      @client = Client.new
    end

    def check_packet_usages
      over_limit_lines.each do |line|

      end
    end

    def over_limit_lines
      client.latest_packet_usages.select do |line|
        line.with_coupon >= 300
      end
    end

    def push

    end
  end
end
