defmodule Words do
  def count(sentence) do
    sentence
      |> String.downcase
      |> scan_for_words
      |> List.flatten
      |> Enum.reduce(%{}, &increment_count/2)
  end

  defp scan_for_words(sentence) do
    Regex.scan(~r/[[:alpha:]\d-]+/u, sentence)
  end

  defp increment_count(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end
