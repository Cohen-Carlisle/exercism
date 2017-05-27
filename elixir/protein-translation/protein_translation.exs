defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    {head_codon, rna_tail} = String.split_at(rna, 3)
    protein = of_codon(head_codon)
    do_of_rna(protein, rna_tail)
  end
  defp do_of_rna(nil, _rna), do: raise "invalid RNA"
  defp do_of_rna(:stop, _rna), do: []
  defp do_of_rna(protein, ""), do: [protein]
  defp do_of_rna(protein, rna) do
    {head_codon, rna_tail} = String.split_at(rna, 3)
    head_protein = of_codon(head_codon)
    [protein | do_of_rna(head_protein, rna_tail)]
  end

  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon("UGU"), do: "Cysteine"
  def of_codon("UGC"), do: "Cysteine"
  def of_codon("UUA"), do: "Leucine"
  def of_codon("UUG"), do: "Leucine"
  def of_codon("AUG"), do: "Methionine"
  def of_codon("UUU"), do: "Phenylalanine"
  def of_codon("UUC"), do: "Phenylalanine"
  def of_codon("UCU"), do: "Serine"
  def of_codon("UCC"), do: "Serine"
  def of_codon("UCA"), do: "Serine"
  def of_codon("UCG"), do: "Serine"
  def of_codon("UGG"), do: "Tryptophan"
  def of_codon("UAU"), do: "Tyrosine"
  def of_codon("UAC"), do: "Tyrosine"
  def of_codon("UAA"), do: :stop
  def of_codon("UAG"), do: :stop
  def of_codon("UGA"), do: :stop
  def of_codon(_), do: nil
end
