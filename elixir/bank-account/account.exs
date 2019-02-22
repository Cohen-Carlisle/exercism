defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank do
    case Agent.start_link(fn -> {:open, 0} end) do
      {:ok, account_pid} -> account_pid
      {:error, _reason} -> {:error, :open_failed}
    end
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, fn {:open, balance} -> {:closed, balance} end)
    nil
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    Agent.get(account, fn
      {:open, balance} ->
        balance

      {:closed, _balance} ->
        {:error, :account_closed}
    end)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    Agent.get_and_update(account, fn
      {:open, balance} ->
        new_balance = balance + amount
        {new_balance, {:open, new_balance}}

      {:closed, balance} ->
        {{:error, :account_closed}, {:closed, balance}}
    end)
  end
end
