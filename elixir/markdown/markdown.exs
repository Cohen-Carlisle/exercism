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
    |> Enum.map(&md_line_to_html/1)
    |> nest_li_in_ul()
    |> Enum.join()
  end

  defp md_line_to_html(line) do
    line
    |> outer_html_tag_and_md_text()
    |> enclose_text_in_tag()
    |> process_inner_md_text()
  end

  defp outer_html_tag_and_md_text(line) do
    case line do
      "* " <> md_text -> {:li, md_text}
      "# " <> md_text -> {:h1, md_text}
      "## " <> md_text -> {:h2, md_text}
      "### " <> md_text -> {:h3, md_text}
      "#### " <> md_text -> {:h4, md_text}
      "##### " <> md_text -> {:h5, md_text}
      "###### " <> md_text -> {:h6, md_text}
      md_text -> {:p, md_text}
    end
  end

  defp enclose_text_in_tag({tag, text}), do: {"<#{tag}>", text, "</#{tag}>"}

  defp process_inner_md_text({outer_open_tag, inner_md_text, outer_close_tag}) do
    inner_md_text
    |> String.replace(~r/__(.+?)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.+?)_/, "<em>\\1</em>")
    |> String.replace_prefix("", outer_open_tag)
    |> String.replace_suffix("", outer_close_tag)
  end

  defp nest_li_in_ul(html_lines) do
    html_lines
    |> Enum.chunk_by(&String.starts_with?(&1, "<li>"))
    |> Enum.flat_map(fn
      ["<li>" <> _ | _] = lines -> ["<ul>" | lines] ++ ["</ul>"]
      lines -> lines
    end)
  end
end
