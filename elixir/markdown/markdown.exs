# TODO: fix doctest
defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("# heading!\n* __Bold Item__\n* _Italic Item_")
    "<h1>heading!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&process_md_line/1)
    |> Enum.join()
    |> patch_html()
  end

  defp process_md_line(line) do
    cond do
      header?(line) -> enclose_in_html_tag(line, :h)
      list?(line) -> enclose_in_html_tag(line, :li)
      true -> enclose_in_html_tag(line, :p)
    end
  end

  # TODO: fix redundancy
  defp header?(line), do: !!parse_heading_level(line)

  defp parse_heading_level("# " <> text), do: {1, text}
  defp parse_heading_level("## " <> text), do: {2, text}
  defp parse_heading_level("### " <> text), do: {3, text}
  defp parse_heading_level("#### " <> text), do: {4, text}
  defp parse_heading_level("##### " <> text), do: {5, text}
  defp parse_heading_level("###### " <> text), do: {6, text}
  defp parse_heading_level(_), do: false

  defp list?(line), do: String.starts_with?(line, "* ")

  # TODO: process_md_words/1
  defp enclose_in_html_tag(line, :h) do
    {heading_level, text} = parse_heading_level(line)
    "<h#{heading_level}>" <> text <> "</h#{heading_level}>"
  end

  defp enclose_in_html_tag(line, :li) do
    text = line |> String.trim_leading("* ")
    "<li>" <> process_md_words(text) <> "</li>"
  end

  defp enclose_in_html_tag(line, tag) do
    "<#{tag}>" <> process_md_words(line) <> "</#{tag}>"
  end

  defp process_md_words(text) do
    text
    |> String.split()
    |> Enum.map(&replace_md_with_html/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_html(word) do
    word
    |> replace_md_prefix()
    |> replace_md_suffix()
  end

  defp replace_md_prefix(word) do
    cond do
      String.starts_with?(word, "__") -> String.replace_prefix(word, "__", "<strong>")
      String.starts_with?(word, "_") -> String.replace_prefix(word, "_", "<em>")
      true -> word
    end
  end

  defp replace_md_suffix(word) do
    cond do
      String.ends_with?(word, "__") -> String.replace_suffix(word, "__", "</strong>")
      String.ends_with?(word, "_") -> String.replace_suffix(word, "_", "</em>")
      true -> word
    end
  end

  defp patch_html(html) do
    html
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
