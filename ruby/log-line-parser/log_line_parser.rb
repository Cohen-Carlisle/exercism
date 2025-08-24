class LogLineParser
  attr_reader :message, :log_level

  def initialize(line)
    line.rstrip.match(/\A\[(?<log_level>[[:alpha:]]+)\]:(?<message>.*)\z/) => {message:, log_level:}
    self.message = message.lstrip
    self.log_level = log_level.downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end

  private

  attr_writer :message, :log_level
end
