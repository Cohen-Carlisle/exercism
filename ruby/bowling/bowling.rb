class Game
  attr_reader :score

  def initialize
    @score = 0
    @frame = 1
    @roll_in_frame = 1
    @last_roll = nil
    @scores = []
  end

  def roll(pins)
    if strike?(pins)
      strike
    elsif continue_frame?(pins)
      continue_frame(pins)
    elsif spare?(pins)
      spare
    elsif open_frame?(pins)
      open_frame(pins)
    else
      raise 'wat'
    end
    handle_score(pins)
  end

  private

  def strike?(pins)
    @roll_in_frame == 1 && pins == 10
  end

  def strike
    @scores << [nil, nil, nil]
    @frame += 1
  end

  def continue_frame?(pins)
    @roll_in_frame == 1 && pins < 10
  end

  def continue_frame(pins)
    @scores << [nil]
    @last_roll = pins
    @roll_in_frame += 1
  end

  def spare?(pins)
    @roll_in_frame == 2 && @last_roll + pins == 10
  end

  def spare
    @scores << [nil, nil]
    @frame += 1
    @last_roll = nil
    @roll_in_frame = 1
  end

  def open_frame?(pins)
    @roll_in_frame == 2 && @last_roll + pins < 10
  end

  def open_frame(pins)
    @scores << [nil]
    @frame += 1
    @last_roll = nil
    @roll_in_frame = 1
  end

  def handle_score(pins)
    @scores.each do |s|
      i = s.index { |ss| ss.nil? }
      s[i] = pins if i
    end
    @score += (@scores.select { |s| s.all? }.flatten.inject(:+) || 0)
    @scores.delete_if { |s| s.all? }
  end
end

module BookKeeping
  VERSION = 1
end
