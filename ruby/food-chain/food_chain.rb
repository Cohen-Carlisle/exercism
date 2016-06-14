class FoodChain
  VERSION = 2

  def self.song
    @filler_verses = []
    8.times.map do |verse|
      [
        first_line(verse),
        second_line(verse),
        filler_verses(verse),
        last_line(verse)
      ].compact.join "\n"
    end.join "\n"
  end

  # private

  def self.first_line(verse_index)
    "I know an old lady who swallowed a #{ANIMALS[verse_index]}."
  end

  def self.second_line(verse_index)
    out = SECOND_LINES[verse_index]
    out += "%s!" % ANIMALS[verse_index] if out&.end_with? " "
    out
  end

  def self.filler_verses(verse_index)
    return unless (1..6).include? verse_index
    @filler_verses.unshift new_filler_verse(verse_index)
    @filler_verses.join "\n"
  end

  def self.last_line(verse_index)
    return "She's dead, of course!\n" if verse_index == 7
    "I don't know why she swallowed the fly. Perhaps she'll die.\n"
  end

  def self.new_filler_verse(verse_index)
    out = "She swallowed the %s to catch the %s" % [ANIMALS[verse_index], ANIMALS[verse_index - 1]]
    out += " that wriggled and jiggled and tickled inside her" if out.end_with? "spider"
    out += "."
  end

  ANIMALS = %w(fly spider bird cat dog goat cow horse)

  SECOND_LINES = [
    nil,
    "It wriggled and jiggled and tickled inside her.",
    "How absurd to swallow a ",
    "Imagine that, to swallow a ",
    "What a hog, to swallow a ",
    "Just opened her throat and swallowed a ",
    "I don't know how she swallowed a "
  ]
end
