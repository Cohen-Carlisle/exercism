class Raindrops
  VERSION = 1

  def self.convert(int)
    out = ''
    out << 'Pling' if int % 3 == 0
    out << 'Plang' if int % 5 == 0
    out << 'Plong' if int % 7 == 0
    out.empty? ? int.to_s : out
  end
end
