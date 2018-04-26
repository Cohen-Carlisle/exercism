defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    do_of_rna(rna, [])
  end

  defp do_of_rna(<<head_codon::bytes-size(3), rna_tail::binary>>, acc) do
    with {:ok, "STOP"} <- of_codon(head_codon) do
      {:ok, Enum.reverse(acc)}
    else
      {:ok, protein} -> do_of_rna(rna_tail, [protein | acc])
      {:error, "invalid codon"} -> {:error, "invalid RNA"}
    end
  end

  defp do_of_rna("", acc) do
    {:ok, Enum.reverse(acc)}
  end

  defp do_of_rna(_rna, _acc) do
    {:error, "invalid RNA"}
  end

  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon("UGU"), do: {:ok, "Cysteine"}
  def of_codon("UGC"), do: {:ok, "Cysteine"}
  def of_codon("UUA"), do: {:ok, "Leucine"}
  def of_codon("UUG"), do: {:ok, "Leucine"}
  def of_codon("AUG"), do: {:ok, "Methionine"}
  def of_codon("UUU"), do: {:ok, "Phenylalanine"}
  def of_codon("UUC"), do: {:ok, "Phenylalanine"}
  def of_codon("UCU"), do: {:ok, "Serine"}
  def of_codon("UCC"), do: {:ok, "Serine"}
  def of_codon("UCA"), do: {:ok, "Serine"}
  def of_codon("UCG"), do: {:ok, "Serine"}
  def of_codon("UGG"), do: {:ok, "Tryptophan"}
  def of_codon("UAU"), do: {:ok, "Tyrosine"}
  def of_codon("UAC"), do: {:ok, "Tyrosine"}
  def of_codon("UAA"), do: {:ok, "STOP"}
  def of_codon("UAG"), do: {:ok, "STOP"}
  def of_codon("UGA"), do: {:ok, "STOP"}
  def of_codon(_), do: {:error, "invalid codon"}
end
