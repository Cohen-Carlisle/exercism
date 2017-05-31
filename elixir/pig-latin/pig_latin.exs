defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    word
    |> calculate_offset
    |> do_translate_word(word)
  end

  defp calculate_offset(word) do
    starts_with_vowel_sound?(word) && 0 || consecutive_consonant_offset(word)
  end

  defp starts_with_vowel_sound?(word) do
    Regex.match?(~r/^(x[^aeiou]|y[^aeiou]|[aeiou])/i, word)
  end

  defp consecutive_consonant_offset(word) do
    ~r/^(qu|[^aeiou])+/i
    |> Regex.run(word)
    |> List.first
    |> String.length
  end

  defp do_translate_word(n, word) do
    String.slice(word, n..-1) <> String.slice(word, 0, n) <> "ay"
  end
end
