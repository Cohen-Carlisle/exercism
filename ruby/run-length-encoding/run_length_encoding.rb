class RunLengthEncoding
  VERSION = 1

  def self.encode(str)
    str.gsub(/(.)\1+/) do |match|
      char = match[0]
      char_count = match.length
      "#{char_count}#{char}"
    end
  end

  def self.decode(str)
    str.gsub(/\d+\D/) do |match|
      char = match[-1]
      char_count = Integer(match[0..-2])
      char * char_count
    end
  end
end
