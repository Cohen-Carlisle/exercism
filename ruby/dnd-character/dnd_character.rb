class DndCharacter
  attr_reader :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma

  def self.modifier(score)
    (score - 10) / 2
  end

  def initialize
    @strength = roll_attribute
    @dexterity = roll_attribute
    @constitution = roll_attribute
    @intelligence = roll_attribute
    @wisdom = roll_attribute
    @charisma = roll_attribute
  end

  def hitpoints
    10 + self.class.modifier(constitution)
  end

  private

  def roll_attribute
    rolls = Array.new(4) { rand(1..6) }
    rolls.sum - rolls.min
  end
end
