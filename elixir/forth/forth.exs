defmodule Forth do
  defstruct [:stack]
  @opaque evaluator :: %Forth{stack: list()}

  @doc """
  Create a new evaluator.
  """
  @spec new :: evaluator
  def new do
    %Forth{stack: []}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(%Forth{} = evaluator, string) when is_binary(string) do
    string
    |> preprocess()
    |> Enum.reduce(evaluator, &do_eval/2)
  end

  defp preprocess(string) do
    string
    |> String.replace(~r/[^[:graph:]]+/u, " ")
    |> String.downcase()
    |> String.split()
  end

  defp do_eval(string_fragment, %Forth{stack: stack} = evaluator) do
    if String.match?(string_fragment, ~r/^[0-9]+$/) do
      %Forth{evaluator | stack: [String.to_integer(string_fragment) | stack]}
    else
      do_command(string_fragment, evaluator)
    end
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

  defp do_command("+", %Forth{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x + y | t]}
  end

  defp do_command("+", %Forth{}) do
    raise Forth.StackUnderflow
  end

  defp do_command("-", %Forth{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x - y | t]}
  end

  defp do_command("-", %Forth{}) do
    raise Forth.StackUnderflow
  end

  defp do_command("*", %Forth{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x * y | t]}
  end

  defp do_command("*", %Forth{}) do
    raise Forth.StackUnderflow
  end

  defp do_command("/", %Forth{stack: [0, _x | _t]}) do
    raise Forth.DivisionByZero
  end

  defp do_command("/", %Forth{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [div(x, y) | t]}
  end

  defp do_command("/", %Forth{}) do
    raise Forth.StackUnderflow
  end

  defp do_command("dup", %Forth{stack: [x | t]} = evaluator) do
    %Forth{evaluator | stack: [x, x | t]}
  end

  defp do_command("dup", %Forth{}) do
    raise Forth.StackUnderflow
  end

  defp do_command("drop", %Forth{stack: [_x | t]} = evaluator) do
    %Forth{evaluator | stack: t}
  end

  defp do_command("drop", %Forth{}) do
    raise Forth.StackUnderflow
  end

  defp do_command("swap", %Forth{stack: [y, x | t]} = evaluator) do
    %Forth{evaluator | stack: [x, y | t]}
  end

  defp do_command("swap", %Forth{}) do
    raise Forth.StackUnderflow
  end

  defp do_command("over", %Forth{stack: [_y, x | _t] = stack} = evaluator) do
    %Forth{evaluator | stack: [x | stack]}
  end

  defp do_command("over", %Forth{}) do
    raise Forth.StackUnderflow
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
