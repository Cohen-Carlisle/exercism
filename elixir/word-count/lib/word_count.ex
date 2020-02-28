defmodule WordCount do
  def count(sentence) do
    sentence
    |> String.downcase()
    |> to_word_list()
    |> to_word_count_map()
  end

  defp to_word_list(sentence) do
    ~r/[[:alnum:]-]+/u
    |> Regex.scan(sentence)
    |> List.flatten()
  end

  defp to_word_count_map(word_list) do
    update_count = fn word, map -> Map.update(map, word, 1, &(&1 + 1)) end
    Enum.reduce(word_list, %{}, update_count)
  end
end
