class Integer
  VERSION = 1
  
  DECIMAL_TO_ROMAN = {
    1000 => 'M',
     900 => 'CM',
     500 => 'D',
     400 => 'CD',
     100 => 'C',
      90 => 'XC',
      50 => 'L',
      40 => 'XL',
      10 => 'X',
       9 => 'IX',
       5 => 'V',
       4 => 'IV',
       1 => 'I'
  }

  def to_roman
    raise "to_roman only defined for 1..3999" unless (1..3999).cover? self
    copy = self
    DECIMAL_TO_ROMAN.each_with_object('') do |decimal_roman, out|
      decimal, roman = decimal_roman
      while copy >= decimal
        copy -= decimal
        out << roman
      end
    end
  end
end
