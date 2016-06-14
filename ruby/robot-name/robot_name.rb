class Robot
  NAMES = {}
  LETTERS = (:A..:Z).to_a

  def self.new_name
    old_size = NAMES.sizez
    until NAMES.size > old_size
      name = [
        LETTERS.sample,
        LETTERS.sample,
        rand(0..9),
        rand(0..9),
        rand(0..9)
      ].join
      NAMES[name] = true unless NAMES.include?(name)
    end
    name
  end

  def initialize
    @name = self.class.new_name
  end

  attr_reader :name

  def reset
    old_name = @name
    @name = self.class.new_name
    NAMES.delete(old_name)
  end
end
