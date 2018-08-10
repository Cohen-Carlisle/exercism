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
      header?(line) -> process_line_as(line, :h)
      list?(line) -> process_line_as(line, :li)
      true -> process_line_as(line, :p)
    end
  end

  defp header?(line), do: !!parse_heading_level(line)

  defp parse_heading_level("# " <> text), do: {1, text}
  defp parse_heading_level("## " <> text), do: {2, text}
  defp parse_heading_level("### " <> text), do: {3, text}
  defp parse_heading_level("#### " <> text), do: {4, text}
  defp parse_heading_level("##### " <> text), do: {5, text}
  defp parse_heading_level("###### " <> text), do: {6, text}
  defp parse_heading_level(_), do: false

  defp list?(line), do: String.starts_with?(line, "* ")

  defp process_line_as(line, :h) do
    {heading_level, text} = parse_heading_level(line)
    "<h#{heading_level}>" <> process_inner_text(text) <> "</h#{heading_level}>"
  end

  defp process_line_as(line, :li) do
    text = line |> String.trim_leading("* ")
    "<li>" <> process_inner_text(text) <> "</li>"
  end

  defp process_line_as(line, :p) do
    "<p>" <> process_inner_text(line) <> "</p>"
  end

  defp process_inner_text(text) do
    text
    |> String.replace(~r/__(.+?)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.+?)_/, "<em>\\1</em>")
  end

  defp patch_html(html) do
    html
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
