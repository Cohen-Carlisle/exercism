defmodule RunLengthEncoder do
  def encode(str) do
    Regex.scan(~r/(.)\1*/, str)
      |> Enum.reduce("", &_encode/2)
  end

  def decode(str) do
    Regex.scan(~r/(\d+)(\D)/, str)
     |> Enum.reduce("", &_decode/2)
  end

  defp _encode(capture, acc) do
    [string, char] = capture
    times = string |> String.length |> Integer.to_string
    acc <> times <> char
  end

  defp _decode(capture, acc) do
    [_, digits, char] = capture
    times = digits |> String.to_integer
    acc <> String.duplicate(char, times)
  end
end
