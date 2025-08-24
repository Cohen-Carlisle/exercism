class LogLineParser
  def initialize(line)
    self.line = line
  end

  def message
    parse_line[:message]
  end

  def log_level
    parse_line[:log_level]
  end

  def reformat
    parse_line => {message:, log_level:}
    "#{message} (#{log_level})"
  end

  private

  attr_accessor :line

  def parse_line
    raw_log_level, raw_message = line.split(":", 2)
    log_level = raw_log_level.tr("[]", "").downcase
    message = raw_message.strip
    {log_level:, message:}
  end
end
