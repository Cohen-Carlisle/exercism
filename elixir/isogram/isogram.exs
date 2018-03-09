defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence), do: do_isogram?(sentence, MapSet.new())

  defp do_isogram?(<<char, rest::binary>>, char_set) when char in ?a..?z do
    if char in char_set do
      false
    else
      do_isogram?(rest, MapSet.put(char_set, char))
    end
  end

  defp do_isogram?(<<char, rest::binary>>, char_set) when char in ?A..?Z do
    do_isogram?(<<char + 32, rest::binary>>, char_set)
  end

  defp do_isogram?(<<_char, rest::binary>>, char_set) do
    do_isogram?(rest, char_set)
  end

  defp do_isogram?("", _char_set) do
    true
  end
end
