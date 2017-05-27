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

  defp translate_word("a" <> _ = word), do: "#{word}ay"
  defp translate_word("e" <> _ = word), do: "#{word}ay"
  defp translate_word("i" <> _ = word), do: "#{word}ay"
  defp translate_word("o" <> _ = word), do: "#{word}ay"
  defp translate_word("u" <> _ = word), do: "#{word}ay"
  defp translate_word("yt" <> _ = word), do: "#{word}ay"
  defp translate_word("xr" <> _ = word), do: "#{word}ay"
  defp translate_word("sch" <> _ = word) do
    "#{String.slice(word, 3..-1)}#{String.slice(word, 0..2)}ay"
  end
  defp translate_word("thr" <> _ = word) do
    "#{String.slice(word, 3..-1)}#{String.slice(word, 0..2)}ay"
  end
  defp translate_word("ch" <> _ = word) do
    "#{String.slice(word, 2..-1)}#{String.slice(word, 0..1)}ay"
  end
  defp translate_word("qu" <> _ = word) do
    "#{String.slice(word, 2..-1)}#{String.slice(word, 0..1)}ay"
  end
  defp translate_word("th" <> _ = word) do
    "#{String.slice(word, 2..-1)}#{String.slice(word, 0..1)}ay"
  end
  defp translate_word(word) do
    if String.match?(word, ~r/^.qu/) do
      "#{String.slice(word, 3..-1)}#{String.slice(word, 0..2)}ay"
    else
      "#{String.slice(word, 1..-1)}#{String.first(word)}ay"
    end
  end
end
