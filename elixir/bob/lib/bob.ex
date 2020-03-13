defmodule Bob do
  @doc """
  Responds like a teenager.
  """
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trimmed_input = String.trim_trailing(input)
    shouted? = shouted?(trimmed_input)
    question? = question?(trimmed_input)

    cond do
      shouted? and question? -> "Calm down, I know what I'm doing!"
      shouted? -> "Whoa, chill out!"
      question? -> "Sure."
      silence?(trimmed_input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  defp shouted?(str) do
    # has uppercase and not lowercase
    Regex.match?(~r/[[:upper:]]/, str) and not Regex.match?(~r/[[:lower:]]/, str)
  end

  defp question?(str) do
    String.ends_with?(str, "?")
  end

  defp silence?(str) do
    str == ""
  end
end
