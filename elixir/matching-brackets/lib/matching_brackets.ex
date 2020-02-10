defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str), do: do_check_brackets(str, [])

  defp do_check_brackets(<<char, rest::binary>>, brackets_list) when char in [?(, ?[, ?{] do
    do_check_brackets(rest, [char | brackets_list])
  end

  defp do_check_brackets(<<char, rest::binary>>, brackets_list) when char in [?), ?], ?}] do
    {head, tail} = List.pop_at(brackets_list, 0)
    brackets_match?(head, char) && do_check_brackets(rest, tail)
  end

  defp do_check_brackets(<<_char, rest::binary>>, brackets_list) do
    do_check_brackets(rest, brackets_list)
  end

  defp do_check_brackets("", []), do: true
  defp do_check_brackets("", [_head | _tail]), do: false

  defp brackets_match?(?(, ?)), do: true
  defp brackets_match?(?[, ?]), do: true
  defp brackets_match?(?{, ?}), do: true
  defp brackets_match?(_left, _right), do: false
end
