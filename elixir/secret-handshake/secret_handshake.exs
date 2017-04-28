defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> do_commands(code &&& 0x01)
    |> do_commands(code &&& 0x02)
    |> do_commands(code &&& 0x04)
    |> do_commands(code &&& 0x08)
    |> do_commands(code &&& 0x10)
  end

  defp do_commands(acc, 0x01), do: acc ++ ["wink"]
  defp do_commands(acc, 0x02), do: acc ++ ["double blink"]
  defp do_commands(acc, 0x04), do: acc ++ ["close your eyes"]
  defp do_commands(acc, 0x08), do: acc ++ ["jump"]
  defp do_commands(acc, 0x10), do: acc |> Enum.reverse
  defp do_commands(acc, _num), do: acc
end
