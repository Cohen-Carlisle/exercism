class Clock
  class << self
    alias at new
  end

  def initialize(hour, minute)
    @hour = 0
    @minute = 0
    add_hours(hour)
    add_minutes(minute)
  end

  def to_s
    "#{padded @hour}:#{padded @minute}"
  end

  def add_minutes(minutes)
    raw_minutes = @minute + minutes
    add_hours(raw_minutes / 60)
    @minute = raw_minutes % 60
    self
  end

  def add_hours(hours)
    @hour = (@hour + hours) % 24
    self
  end

  alias + add_minutes

  def ==(rhs)
    rhs.is_a?(self.class) && to_s == rhs.to_s
  end

  private

  def padded(int)
    int.to_s.rjust(2, '0')
  end
end

module BookKeeping
  VERSION = 2
end
