class BeerSong
  VERSION = 2

  def verse(num)
    first_line(num) + second_line(num)
  end

  def verses(start, finish)
    start.downto(finish).map do |num|
      first_line(num) + second_line(num)
    end.join("\n")
  end

  def lyrics
    verses(99, 0)
  end

  private

  def first_line(num)
    case num
    when 0
      "No more bottles of beer on the wall, no more bottles of beer.\n"
    when 1
      "1 bottle of beer on the wall, 1 bottle of beer.\n"
    else
      "#{num} bottles of beer on the wall, #{num} bottles of beer.\n"
    end
  end

  def second_line(num)
    case num
    when 0
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    when 1
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    when 2
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    else
      "Take one down and pass it around, #{num-1} bottles of beer on the wall.\n"
    end
  end
end
