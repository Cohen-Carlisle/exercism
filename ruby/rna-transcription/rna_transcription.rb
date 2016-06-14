module Complement
  VERSION = 3

  DNA_TO_RNA = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }

  module_function

  def of_dna(strand)
    raise ArgumentError, "only #{dna_nucleotides} allowed" if invalid?(strand)
    strand.tr(dna_nucleotides, rna_nucleotides)
  end

  # private

  def dna_nucleotides
    DNA_TO_RNA.keys.join
  end

  def rna_nucleotides
    DNA_TO_RNA.values.join
  end

  def invalid?(strand)
    strand =~ /[^#{dna_nucleotides}]/
  end

  private_class_method *%i(dna_nucleotides rna_nucleotides invalid?)

end
