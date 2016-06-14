class PhoneNumber
  attr_reader :number

  DEFAULT_NUMBER = '0000000000'.freeze

  def initialize(str)
    cleaned = str.gsub(/[ ()-.]/, '')
    if cleaned =~ /[^0-9]/
      @number = DEFAULT_NUMBER
    elsif cleaned.length == 11 && cleaned.start_with?('1')
      @number = cleaned[1..-1]
    elsif cleaned.length == 10
      @number = cleaned
    else
      @number = DEFAULT_NUMBER
    end
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{area_code}) #{number[3..5]}-#{number[6..9]}"
  end
end
