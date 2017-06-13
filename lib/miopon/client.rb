require 'json'
require 'rest-client'
require_relative './packet'

module Miopon
  COUPON = "https://api.iijmio.jp/mobile/d/v2/coupon/"
  PACKET = "https://api.iijmio.jp/mobile/d/v2/log/packet/"

  class ParameterError < StandardError; end

  class Client

    attr_reader :dev_id, :token

    def initialize
      @dev_id = ENV["IIJMIO_DEVELOPER_ID"]
      @token = ENV["IIJMIO_AUTHORIZATION"]
      raise ParameterError unless (@dev_id && @token)
    end

    def latest_packet_usages
      res = RestClient.get(PACKET, headers = default_headers)
      packet_info = PacketInfo.new res.body
      packet_info.latest_packet_usages
    end

    def coupon_on(service_code)
      res = RestClient.put(COUPON, coupon_payload(service_code, true), headers = coupon_headers)
    end

    def coupon_off(service_code)
      res = RestClient.put(COUPON, coupon_payload(service_code, false), headers = coupon_headers)
    end

    def coupon_payload(service_code, coupon_use)
      payload = {
        "couponInfo": [
          { "hdoInfo": [{ "hdoServiceCode": service_code, "couponUse": coupon_use }] }
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
