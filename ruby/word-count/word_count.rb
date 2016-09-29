class Phrase
  VERSION = 1

  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    Hash[word_count_ary]
  end

  private

  def words
    @phrase.downcase.scan(/\b[\w']+\b/)
  end

  def word_count_ary
    words.group_by { |word| word }.map { |k,v| [k,v.count] }
  end
end
