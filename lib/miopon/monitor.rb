require 'washbullet'
require 'dalli'

module Miopon
  class Monitor

    PACKET_USAGE_LIMIT = 300

    attr_reader :miopon_client, :pushbullet_client, :pushbullet_identifier

    def initialize
      @pushbullet_api_key = ENV["PUSHBULLET_API_KEY"]
      @pushbullet_identifier = ENV["PUSHBULLET_IDENTIFIER"]
      raise ParameterError unless @pushbullet_api_key && @pushbullet_identifier

      @miopon_client = Client.new
      @pushbullet_client = Washbullet::Client.new(@pushbullet_api_key)
      @memcache_client = memcached_client
    end

    def memcached_client
      @memcached_client ||= Dalli::Client.new((ENV['MEMCACHIER_SERVERS'] || 'localhost').split(','),
        {
          username: ENV['MEMCACHIER_USERNAME'] || '',
          password: ENV['MEMCACHIER_PASSWORD'] || '',
          failover: true,
          socket_timeout: 1.5,
          socket_failure_delay: 0.2,
          expires_in: 3600 * 12
        }
      )
    end

    def stats
      [].tap do |out|
        miopon_client.latest_packet_usages.each do |line|
          out << "#{line.date}: #{line.code} uses #{line.with_coupon}MB"
        end
      end
    end

    def check_packet_usages
      over_limit_lines.each do |line|
        line.with_coupon >= PACKET_USAGE_LIMIT
      end
    end

    def over_limit_lines
      miopon_client.latest_packet_usages.select do |line|
        line.with_coupon >= PACKET_USAGE_LIMIT
      end
    end

    def already_notified?(code)
      !memcached_client.get(code).nil?
    end

    def mark_as_notified(code)
      memcached_client.set(code, "notified")
    end

    def notify(line)
      return if already_notified?(line.code)
      pushbullet_client.push_note(
        receiver: :email,
        identifier: pushbullet_identifier,
        params: {
          title: "A notice from Be Moderate",
          body: "#{line.code} uses #{line.with_coupon}MB today!"
        }
      )
    end
  end
end
