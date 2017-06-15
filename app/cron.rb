require_relative "../lib/miopon"

monitor = Miopon::Monitor.new
monitor.over_limit_lines.each do |line|
  monitor.notify line
end
