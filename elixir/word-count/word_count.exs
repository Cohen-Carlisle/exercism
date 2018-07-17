defmodule Words do
  def count(sentence) do
    sentence
    |> String.downcase()
    |> to_word_list()
    |> to_word_count_map()
  end

  defp to_word_list(sentence) do
    ~r/[[:alpha:]\d-]+/u
    |> Regex.scan(sentence)
    |> List.flatten()
  end

  defp to_word_count_map(word_list) do
    update_count = fn word, acc -> Map.update(acc, word, 1, &(&1 + 1)) end
    Enum.reduce(word_list, %{}, update_count)
  end
end
