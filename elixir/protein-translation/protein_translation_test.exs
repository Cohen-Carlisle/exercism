if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("protein_translation.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule ProteinTranslationTest do
  use ExUnit.Case

  #@tag :pending
  test "AUG translates to methionine" do
    assert ProteinTranslation.of_codon("AUG") == "Methionine"
  end

  # @tag :pending
  test "identifies Phenylalanine codons" do
    assert ProteinTranslation.of_codon("UUU") == "Phenylalanine"
    assert ProteinTranslation.of_codon("UUC") == "Phenylalanine"
  end

  # @tag :pending
  test "identifies Leucine codons" do
    assert ProteinTranslation.of_codon("UUA") == "Leucine"
    assert ProteinTranslation.of_codon("UUG") == "Leucine"
  end

  # @tag :pending
  test "identifies Serine codons" do
    assert ProteinTranslation.of_codon("UCU") == "Serine"
    assert ProteinTranslation.of_codon("UCC") == "Serine"
    assert ProteinTranslation.of_codon("UCA") == "Serine"
    assert ProteinTranslation.of_codon("UCG") == "Serine"
  end

  # @tag :pending
  test "identifies Tyrosine codons" do
    assert ProteinTranslation.of_codon("UAU") == "Tyrosine"
    assert ProteinTranslation.of_codon("UAC") == "Tyrosine"
  end

  # @tag :pending
  test "identifies Cysteine codons" do
    assert ProteinTranslation.of_codon("UGU") == "Cysteine"
    assert ProteinTranslation.of_codon("UGC") == "Cysteine"
  end

  # @tag :pending
  test "identifies Tryptophan codons" do
    assert ProteinTranslation.of_codon("UGG") == "Tryptophan"
  end

  # @tag :pending
  test "identifies stop codons" do
    assert ProteinTranslation.of_codon("UAA") == :stop
    assert ProteinTranslation.of_codon("UAG") == :stop
    assert ProteinTranslation.of_codon("UGA") == :stop
  end

  # @tag :pending
  test "translates rna strand into correct protein" do
    strand = "AUGUUUUGG"
    assert ProteinTranslation.of_rna(strand) == ~w(Methionine Phenylalanine Tryptophan)
  end

  # @tag :pending
  test "stops translation if stop codon present" do
    strand = "AUGUUUUAA"
    assert ProteinTranslation.of_rna(strand) == ~w(Methionine Phenylalanine)
  end

  # @tag :pending
  test "stops translation of longer strand" do
    strand = "UGGUGUUAUUAAUGGUUU"
    assert ProteinTranslation.of_rna(strand) == ~w(Tryptophan Cysteine Tyrosine)
  end

  # @tag :pending
  test "invalid RNA" do
    assert_raise RuntimeError, "invalid RNA", fn ->
      ProteinTranslation.of_rna("CARROT")
    end
  end

  # @tag :pending
  test "invalid codon" do
    assert ProteinTranslation.of_codon("INVALID") == nil
  end
end
