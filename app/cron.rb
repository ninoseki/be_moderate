require_relative "../lib/miopon"

include Miopon::Utils

def job
  monitor = Miopon::Monitor.new
  # notify
  monitor.over_limit_lines.each do |line|
    monitor.notify line
    monitor.mark_as_notified line.code
  end
  # stats
  monitor.stats.each do |s|
    puts s
  end
end

with_error_notify { job }
