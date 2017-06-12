defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(n) do
    n
    |> maybe_pling
    |> maybe_plang(n)
    |> maybe_plong(n)
    |> sound_or_num(n)
  end

  defp maybe_pling(n) when rem(n, 3) == 0, do: "Pling"
  defp maybe_pling(_n), do: ""

  defp maybe_plang(str, n) when rem(n, 5) == 0, do: str <> "Plang"
  defp maybe_plang(str, _n), do: str

  defp maybe_plong(str, n) when rem(n, 7) == 0, do: str <> "Plong"
  defp maybe_plong(str, _n), do: str

  defp sound_or_num("", n), do: Integer.to_string(n)
  defp sound_or_num(str, _n), do: str
end
