defmodule BracketPush do
  @left_parenthesis ?(
  @right_parenthesis ?)

  @left_square_bracket ?[
  @right_square_bracket ?]

  @left_curly_bracket ?{
  @right_curly_bracket ?}

  @right_brackets [@right_parenthesis, @right_square_bracket, @right_curly_bracket]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str), do: do_check_brackets(str, [])

  defp do_check_brackets(str, bracket_list)

  defp do_check_brackets(<<@left_parenthesis, rest::binary>>, bracket_list) do
    do_check_brackets(rest, [@left_parenthesis | bracket_list])
  end

  defp do_check_brackets(<<@left_square_bracket, rest::binary>>, bracket_list) do
    do_check_brackets(rest, [@left_square_bracket | bracket_list])
  end

  defp do_check_brackets(<<@left_curly_bracket, rest::binary>>, bracket_list) do
    do_check_brackets(rest, [@left_curly_bracket | bracket_list])
  end

  defp do_check_brackets(<<@right_parenthesis, rest::binary>>, [@left_parenthesis | tail]) do
    do_check_brackets(rest, tail)
  end

  defp do_check_brackets(<<@right_square_bracket, rest::binary>>, [@left_square_bracket | tail]) do
    do_check_brackets(rest, tail)
  end

  defp do_check_brackets(<<@right_curly_bracket, rest::binary>>, [@left_curly_bracket | tail]) do
    do_check_brackets(rest, tail)
  end

  defp do_check_brackets(<<char, rest::binary>>, bracket_list) when char not in @right_brackets do
    do_check_brackets(rest, bracket_list)
  end

  defp do_check_brackets("", []) do
    true
  end

  defp do_check_brackets(_str, _bracket_list) do
    false
  end
end
