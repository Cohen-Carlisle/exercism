defmodule LogLevel do
  def to_label(level, is_legacy)
  def to_label(0, false), do: :trace
  def to_label(1, _), do: :debug
  def to_label(2, _), do: :info
  def to_label(3, _), do: :warning
  def to_label(4, _), do: :error
  def to_label(5, false), do: :fatal
  def to_label(_, _), do: :unknown

  def alert_recipient(level, is_legacy) do
    case to_label(level, is_legacy) do
      level when level in [:trace, :debug, :info, :warning] -> nil
      level when level in [:error, :fatal] -> :ops
      _ -> handle_unknown(is_legacy)
    end
  end

  defp handle_unknown(true), do: :dev1
  defp handle_unknown(false), do: :dev2
end
