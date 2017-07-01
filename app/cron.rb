require_relative "../lib/miopon"

include Miopon::Utils

with_error_notify do
  monitor = Miopon::Monitor.new
  # notify
  monitor.over_limit_lines.each do |line|
    monitor.notify line
  end
  # stats
  monitor.stats.each do |s|
    puts s
  end
end
