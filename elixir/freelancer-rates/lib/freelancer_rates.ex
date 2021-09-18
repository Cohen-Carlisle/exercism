defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    raw_monthly_rate = daily_rate(hourly_rate) * 22

    raw_monthly_rate
    |> apply_discount(discount)
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_discounted_rate =
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)

    Float.floor(budget / daily_discounted_rate, 1)
  end
end
