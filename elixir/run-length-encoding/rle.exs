defmodule RunLengthEncoder do
  def encode(str) do
    ~r/(.)\1*/
    |> Regex.scan(str)
    |> Enum.reduce("", &do_encode/2)
  end

  def decode(str) do
    ~r/(\d*)(\D)/
    |> Regex.scan(str)
    |> Enum.reduce("", &do_decode/2)
  end

  defp do_encode([string, char], acc) when byte_size(string) == 1 do
    acc <> char
  end

  defp do_encode([string, char], acc) do
    times = string |> String.length() |> Integer.to_string()
    acc <> times <> char
  end

  defp do_decode([_, "", char], acc) do
    acc <> char
  end

  defp do_decode([_, digits, char], acc) do
    times = digits |> String.to_integer()
    acc <> String.duplicate(char, times)
  end
end
