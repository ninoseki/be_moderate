# frozen_string_literal: true

require_relative "../lib/miopon"

include Miopon::Utils

def monitor_job
  monitor = Miopon::Monitor.new

  monitor.over_limit_lines.each do |line|
    monitor.notify line
    monitor.mark_as_notified line.code
  end
  monitor.stats.each { |s| puts s }
end

def coupon_job
  client = Miopon::Client.new
  client.coupon
end

with_error_notify do
  monitor_job
  coupon_job
end
