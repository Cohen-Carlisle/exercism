module RotationalCipher
  UPPERCASE_ALPHABET = (?A..?Z).to_a
  LOWERCASE_ALPHABET = UPPERCASE_ALPHABET.map(&:downcase)

  def self.rotate(plaintext, shift)
    plaintext.tr(
      (UPPERCASE_ALPHABET + LOWERCASE_ALPHABET).join,
      (UPPERCASE_ALPHABET.rotate(shift) + LOWERCASE_ALPHABET.rotate(shift)).join
    )
  end
end

module BookKeeping
  VERSION = 1
end
