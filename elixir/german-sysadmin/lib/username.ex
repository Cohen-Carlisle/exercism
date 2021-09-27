defmodule Username do
  def sanitize(username) do
    do_sanitize(username, '')
  end

  defp do_sanitize([c | rest], alias) when c in ?a..?z, do: do_sanitize(rest, [c | alias])
  defp do_sanitize([?_ | rest], alias), do: do_sanitize(rest, [?_ | alias])
  defp do_sanitize([?ä | rest], alias), do: do_sanitize(rest, ['ae' | alias])
  defp do_sanitize([?ö | rest], alias), do: do_sanitize(rest, ['oe' | alias])
  defp do_sanitize([?ü | rest], alias), do: do_sanitize(rest, ['ue' | alias])
  defp do_sanitize([?ß | rest], alias), do: do_sanitize(rest, ['ss' | alias])
  defp do_sanitize([_c | rest], alias), do: do_sanitize(rest, alias)
  defp do_sanitize('', alias), do: alias |> Enum.reverse() |> List.flatten()
end
