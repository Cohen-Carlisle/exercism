defmodule Username do
  def sanitize(username) do
    Enum.flat_map(username, &do_sanitize/1)
  end

  defp do_sanitize(char) do
    case char do
      char when char in ?a..?z -> [char]
      ?_ -> '_'
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> ''
    end
  end
end
