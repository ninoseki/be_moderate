module Miopon
  class PacketInfo
    attr_reader :json

    def initialize(body)
      @json = JSON.parse(body)
    end

    def packet_log
      json["packetLogInfo"]
    end

    def latest_packet_usages
      [].tap do |arr|
        json["packetLogInfo"].each do |packet_info|
          packet_info["hdoInfo"].each do |hdo_info|
            arr << Line.new(hdo_info)
          end
        end
      end
    end
  end

  class Line
    attr_reader :code, :date, :with_coupon
    def initialize(hdo_info)
      @code = hdo_info["hdoServiceCode"]
      last_day = hdo_info["packetLog"].last
      @date = last_day["date"]
      @with_coupon = last_day["withCoupon"].to_i

      raise ParameterError unless (@code && @date && @with_coupon)
    end
  end
end
