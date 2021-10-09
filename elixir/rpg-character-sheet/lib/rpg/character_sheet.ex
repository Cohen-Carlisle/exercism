defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  def ask_name() do
    prompt_for_string("What is your character's name?")
  end

  def ask_class() do
    prompt_for_string("What is your character's class?")
  end

  def ask_level() do
    prompt_for_integer("What is your character's level?")
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()
    character = %{name: name, class: class, level: level}
    IO.puts("Your character: #{inspect(character)}")
    character
  end

  defp prompt_for_string(device \\ :stdio, prompt) do
    device
    |> IO.gets(prompt <> "\n")
    |> String.trim()
  end

  defp prompt_for_integer(device \\ :stdio, prompt) do
    device
    |> prompt_for_string(prompt)
    |> String.to_integer()
  end
end
