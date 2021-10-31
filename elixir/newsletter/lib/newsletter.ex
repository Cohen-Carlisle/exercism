defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(fn email -> email |> send_fun.() |> log_if_ok(pid, email) end)

    close_log(pid)
  end

  defp log_if_ok(:ok, pid, email), do: log_sent_email(pid, email)
  defp log_if_ok(_, _, _), do: nil
end
