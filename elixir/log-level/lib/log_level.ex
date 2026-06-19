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
    label = to_label(level, is_legacy)

    case {label, is_legacy} do
      {label, _} when label in [:trace, :debug, :info, :warning] -> false
      {label, _} when label in [:error, :fatal] -> :ops
      {:unknown, true} -> :dev1
      {:unknown, false} -> :dev2
    end
  end
end
