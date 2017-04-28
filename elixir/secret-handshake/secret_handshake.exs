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
    |> maybe_wink(code)
    |> maybe_double_blink(code)
    |> maybe_close_your_eyes(code)
    |> maybe_jump(code)
    |> maybe_reverse(code)
  end

  defp maybe_wink(acc, code) do
    if (code &&& 1) == 1 do
      acc ++ ["wink"]
    else
      acc
    end
  end

  defp maybe_double_blink(acc, code) do
    if (code &&& 2) == 2 do
      acc ++ ["double blink"]
    else
      acc
    end
  end

  defp maybe_close_your_eyes(acc, code) do
    if (code &&& 4) == 4 do
      acc ++ ["close your eyes"]
    else
      acc
    end
  end

  defp maybe_jump(acc, code) do
    if (code &&& 8) == 8 do
      acc ++ ["jump"]
    else
      acc
    end
  end

  defp maybe_reverse(acc, code) do
    if (code &&& 16) == 16 do
      Enum.reverse(acc)
    else
      acc
    end
  end
end
