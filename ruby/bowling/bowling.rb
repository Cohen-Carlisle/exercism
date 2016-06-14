class Game
  VERSION = 1

  def initialize
    @score = 0
    @frame = 1
    @roll_in_frame = 1
    @last_roll = nil
    @scores = []
  end

  def roll(pins)
    raise_error_if_invalid(pins)

    if fill_ball?
      fill_ball(pins)
    elsif strike?(pins)
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

  def score
    unless game_over?
      raise "Score cannot be taken until the end of the game"
    end
    @score
  end

  private

  def fill_ball?
    @frame > 10
  end

  def fill_ball(pins)
    @last_roll = pins if pins < 10
  end

  def strike?(pins)
    @frame <= 10 && @roll_in_frame == 1 && pins == 10
  end

  def strike
    @scores << [nil, nil, nil]
    @frame += 1
  end

  def continue_frame?(pins)
    @frame <= 10 && @roll_in_frame == 1 && pins < 10
  end

  def continue_frame(pins)
    @scores << [nil]
    @last_roll = pins
    @roll_in_frame += 1
  end

  def spare?(pins)
    @frame <= 10 && @roll_in_frame == 2 && @last_roll + pins == 10
  end

  def spare
    @scores << [nil, nil]
    @frame += 1
    @last_roll = nil
    @roll_in_frame = 1
  end

  def open_frame?(pins)
    @frame <= 10 && @roll_in_frame == 2 && @last_roll + pins < 10
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

  def raise_error_if_invalid(pins)
    raise "Pins must have a value from 0 to 10" unless (0..10).cover?(pins)
    raise "Pin count exceeds pins on the lane" if (@last_roll || 0) + pins > 10
    raise "Should not be able to roll after game is over" if game_over?
  end

  def game_over?
    @frame > 10 && @scores.empty?
  end
end
