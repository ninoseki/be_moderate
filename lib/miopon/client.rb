require 'json'
require 'rest-client'
require_relative './packet'

module Miopon
  COUPON = "https://api.iijmio.jp/mobile/d/v2/coupon/".freeze
  PACKET = "https://api.iijmio.jp/mobile/d/v2/log/packet/".freeze

  class Client
    attr_reader :dev_id, :token

    def initialize
      @dev_id = ENV["IIJMIO_DEVELOPER_ID"]
      @token = ENV["IIJMIO_AUTHORIZATION"]
      raise ArgumentError, "IIJMIO_DEVELOPER_ID & IIJMIO_AUTHORIZATION are required" unless @dev_id && @token
    end

    def latest_packet_usages
      @res ||= RestClient.get(PACKET, default_headers)
      packet_info = PacketInfo.new @res.body
      packet_info.latest_packet_usages
    end

    def coupon(payload = coupon_payload)
      RestClient.put(COUPON, payload, coupon_headers)
    end

    def coupon_payload
      payload = {
        "couponInfo": [
          { "hdoInfo": latest_packet_usages.map(&:coupon_payload) }
        ]
      }
      JSON.generate payload
    end

    def default_headers
      {
        "X-IIJmio-Developer": dev_id,
        "X-IIJmio-Authorization": token
      }
    end

    def coupon_headers
      default_headers.merge({ "Content-Type": "application/json" })
    end
  end
end
