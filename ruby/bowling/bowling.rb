class Game
  VERSION = 1

  def initialize
    @frame = 1
    @roll_in_frame = 1
    @pins_remaining = 10
    @score = 0
    @pending_scores = []
  end

  def roll(pins)
    raise_error_if_invalid(pins)

    if fill_ball?
      fill_ball(pins)
    elsif strike?(pins)
      strike
    elsif spare?(pins)
      spare
    elsif open_frame?(pins)
      open_frame(pins)
    else
      continue_frame(pins)
    end

    handle_score(pins)
  end

  def score
    raise "Score cannot be taken until the end of the game" unless game_over?
    @score
  end

  private

  def fill_ball?
    @frame > 10
  end

  def fill_ball(pins)
    strike?(pins) ? reset_pins : @pins_remaining -= pins
  end

  def strike?(pins)
    @roll_in_frame == 1 && pins == 10
  end

  def strike
    @pending_scores << [nil, nil, nil]
    reset_pins
  end

  def spare?(pins)
    @roll_in_frame == 2 && @pins_remaining == pins
  end

  def spare
    @pending_scores << [nil, nil]
    reset_pins
  end

  def open_frame?(pins)
    @roll_in_frame == 2 && @pins_remaining > pins
  end

  def open_frame(pins)
    @pending_scores << [nil]
    reset_pins
  end

  def continue_frame(pins)
    @pending_scores << [nil]
    @pins_remaining -= pins
    @roll_in_frame += 1
  end

  def handle_score(pins)
    @pending_scores.each do |s|
      i = s.index { |ss| ss.nil? }
      s[i] = pins if i
    end
    @score += @pending_scores.select { |s| s.all? }.flatten.inject(0, :+)
    @pending_scores.delete_if { |s| s.all? }
  end

  def raise_error_if_invalid(pins)
    raise "Pins must have a value from 0 to 10" unless (0..10).cover?(pins)
    raise "Pin count exceeds pins on the lane" if @pins_remaining < pins
    raise "Should not be able to roll after game is over" if game_over?
  end

  def reset_pins
    @frame += 1
    @roll_in_frame = 1
    @pins_remaining = 10
  end

  def game_over?
    @frame > 10 && @pending_scores.empty?
  end
end
