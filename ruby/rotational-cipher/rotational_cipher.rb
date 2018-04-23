module RotationalCipher
  class << self
    def rotate(plaintext, shift)
      plaintext.codepoints.map do |codepoint|
        case codepoint
        when ?a.ord..?z.ord
          (codepoint + shift - ?a.ord) % 26 + ?a.ord
        when ?A.ord..?Z.ord
          (codepoint + shift - ?A.ord) % 26 + ?A.ord
        else
          codepoint
        end
      end.map { |rc| rc.chr }.join
    end
  end
end

module BookKeeping
  VERSION = 1
end
