defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    do_extract(data, String.split(path, "."))
  end

  defp do_extract(data, [h | t]), do: do_extract(data[h], t)
  defp do_extract(data, []), do: data

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
