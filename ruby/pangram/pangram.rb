class Pangram
  VERSION = 1

  def self.is_pangram?(str)
    downcased_str = str.downcase
    (?a..?z).all? { |char| downcased_str.include?(char) }
  end
end
