defmodule Forth do
  defstruct [:stack, :aliases]
  @opaque evaluator :: %Forth{stack: list(integer()), aliases: keyword(String.t())}

  @doc """
  Create a new evaluator.
  """
  @spec new :: evaluator
  def new do
    %Forth{stack: [], aliases: []}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(%Forth{} = evaluator, string) when is_binary(string) do
    string
    |> preprocess_string()
    |> process_aliases(evaluator)
    |> do_eval()
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(%Forth{stack: stack}) do
    stack
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp preprocess_string(string) do
    string
    |> String.replace(~r/[^[:graph:]]+/u, " ")
    |> String.downcase()
  end

  defp process_aliases(string, evaluator) do
    new_aliases =
      ~r/(?<=^| ): (.+?) ;(?= |$)/u
      |> Regex.scan(string, capture: :all_but_first)
      |> Enum.reduce([], fn [alias_string], aliases ->
        [name, expansion] = String.split(alias_string, " ", parts: 2)

        if String.match?(name, ~r/^[0-9]+$/) do
          raise Forth.InvalidWord, word: name
        end

        Keyword.put(aliases, String.to_atom(name), expansion)
      end)
      |> Enum.reverse()

    updated_aliases =
      List.foldr(evaluator.aliases, new_aliases, fn {name, expansion}, aliases ->
        Keyword.put_new(aliases, name, expansion)
      end)

    string_without_aliases = String.replace(string, ~r/(?<=^| ): (.+?) ;(?= |$)/u, "")

    expanded_string =
      Enum.reduce(updated_aliases, string_without_aliases, fn {name, expansion}, string ->
        String.replace(string, Atom.to_string(name), expansion)
      end)

    {expanded_string, %Forth{evaluator | aliases: updated_aliases}}
  end

  defp do_eval({string, evaluator}) do
    string
    |> String.split()
    |> Enum.reduce(evaluator, &handle_command/2)
  end

  defp handle_command(command, %{stack: stack} = evaluator) do
    if String.match?(command, ~r/^[0-9]+$/) do
      %Forth{evaluator | stack: [String.to_integer(command) | stack]}
    else
      do_command(command, evaluator)
    end
  end

  defp do_command("+", %{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x + y | t]}
  end

  defp do_command("+", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command("-", %{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x - y | t]}
  end

  defp do_command("-", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command("*", %{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x * y | t]}
  end

  defp do_command("*", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command("/", %{stack: [0, _x | _t]}) do
    raise Forth.DivisionByZero
  end

  defp do_command("/", %{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [div(x, y) | t]}
  end

  defp do_command("/", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command("dup", %{stack: [x | t]} = evaluator) do
    %Forth{evaluator | stack: [x, x | t]}
  end

  defp do_command("dup", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command("drop", %{stack: [_x | t]} = evaluator) do
    %Forth{evaluator | stack: t}
  end

  defp do_command("drop", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command("swap", %{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x, y | t]}
  end

  defp do_command("swap", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command("over", %{stack: [_y, x | _t] = stack} = evaluator) do
    %Forth{evaluator | stack: [x | stack]}
  end

  defp do_command("over", _evaluator) do
    raise Forth.StackUnderflow
  end

  defp do_command(word, _evaluator) do
    raise Forth.UnknownWord, word: word
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
