require_relative "../lib/miopon"

include Miopon::Utils

with_error_notify do
  monitor = Miopon::Monitor.new
  monitor.over_limit_lines.each do |line|
    monitor.notify line
  end
end
