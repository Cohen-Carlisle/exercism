if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("markdown.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule MarkdownTest do
  use ExUnit.Case

  # @tag :pending
  test "parses normal text as a paragraph" do
    input = "This will be a paragraph"
    expected = "<p>This will be a paragraph</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "parsing italics" do
    input = "_This will be italic_"
    expected = "<p><em>This will be italic</em></p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "parsing bold text" do
    input = "__This will be bold__"
    expected = "<p><strong>This will be bold</strong></p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "mixed normal, italics and bold text" do
    input = "This will _be_ __mixed__"
    expected = "<p>This will <em>be</em> <strong>mixed</strong></p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "with h1 header level" do
    input = "# This will be an h1"
    expected = "<h1>This will be an h1</h1>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "with h2 header level" do
    input = "## This will be an h2"
    expected = "<h2>This will be an h2</h2>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "with h6 header level" do
    input = "###### This will be an h6"
    expected = "<h6>This will be an h6</h6>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "unordered lists" do
    input = "* Item 1\n* Item 2"
    expected = "<ul><li>Item 1</li><li>Item 2</li></ul>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "with a little bit of everything" do
    input = "# Header!\n* __Bold Item__\n* _Italic Item_"

    expected =
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"

    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should not remove _ from the middle of words when processing prefix" do
    input = "{foo_bar"
    expected = "<p>{foo_bar</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should not process <em> without </em>" do
    input = "_foo"
    expected = "<p>_foo</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should not process <strong> without </strong>" do
    input = "__foo"
    expected = "<p>__foo</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should not process </em> without <em>" do
    input = "foo_"
    expected = "<p>foo_</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should not process </strong> without <strong>" do
    input = "foo__"
    expected = "<p>foo__</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "does not produce invalid heading levels" do
    input = String.duplicate("#", 7) <> " h7? Madness!"
    expected = "<p>####### h7? Madness!</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "requires space between heading markdown and text" do
    input = "#hashtag"
    expected = "<p>#hashtag</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "requires space between list markdown " do
    input = "*splat"
    expected = "<p>*splat</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "heading should be able to be styled further" do
    input = "# __Bold Header__"
    expected = "<h1><strong>Bold Header</strong></h1>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should style in a non-greedy fashion with <em>" do
    input = "_foo_ and _bar_"
    expected = "<p><em>foo</em> and <em>bar</em></p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should style in a non-greedy fashion with <strong>" do
    input = "__foo__ and __bar__"
    expected = "<p><strong>foo</strong> and <strong>bar</strong></p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should style subwords with <em>" do
    input = "_foo_bar"
    expected = "<p><em>foo</em>bar</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should style subwords with <strong>" do
    input = "__foo__bar"
    expected = "<p><strong>foo</strong>bar</p>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "should handle multiple lists" do
    input = "# 1\n* a\n* b\n# 2\n* c\n* d"
    expected = "<h1>1</h1><ul><li>a</li><li>b</li></ul><h1>2</h1><ul><li>c</li><li>d</li></ul>"
    assert Markdown.parse(input) == expected
  end

  # @tag :pending
  test "terminates non-terminal lists" do
    input = "* 1\n* 2\n# Fin"
    expected = "<ul><li>1</li><li>2</li></ul><h1>Fin</h1>"
    assert Markdown.parse(input) == expected
  end
end
