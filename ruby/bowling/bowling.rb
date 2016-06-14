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
    if @roll_in_frame == 1
      if pins == 10 # strike
        # p 'strike'
        @scores.each do |s|
          if (i = s.index { |ss| ss.nil? })
            s[i] = 10
          end
        end << [10, nil, nil]
        @frame += 1
      else
        # p 'first roll, nonstrike'
        @last_roll = pins
        @roll_in_frame += 1
      end
    elsif @last_roll + pins == 10 # spare
      # p 'spare'
      @scores.each do |s|
        if (i = s.index { |ss| ss.nil? })
          s[i] = 10
        end
      end << [10, nil]
      @frame += 1
      @last_roll = nil
      @roll_in_frame = 1
    else # open frame
      # p 'open frame'
      score = @last_roll + pins
      @scores.each do |s|
        if (i = s.index { |ss| ss.nil? })
          s[i] = score
        end
      end << [score]
      @frame += 1
      @last_roll = nil
      @roll_in_frame = 1
    end
    # p @scores
    @score += (@scores.select { |s| s.all? }.flatten.inject(:+) || 0)
    @scores.delete_if { |s| s.all? }
  end
end

module BookKeeping
  VERSION = 1
end
