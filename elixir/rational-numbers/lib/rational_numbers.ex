defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({n1, d1}, {n2, d2}) do
    reduce({n1 * d2 + n2 * d1, d1 * d2})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, {n, d}), do: add(a, {-n, d})

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({n1, d1}, {n2, d2}) do
    reduce({n1 * n2, d1 * d2})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(a :: rational, den :: rational) :: rational
  def divide_by(a, {n, d}), do: multiply(a, {d, n})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({n, d}) do
    reduce({Kernel.abs(n), Kernel.abs(d)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, exponent :: integer) :: rational
  def pow_rational({n, d}, exponent) when exponent < 0, do: pow_rational({d, n}, -exponent)
  def pow_rational({n, d}, exponent) do
    reduce({n ** exponent, d ** exponent})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(base :: integer, exponent :: rational) :: float
  def pow_real(base, {n, d}) do
    base ** (n/d)
    # Exponentiation of a real number `x` to a rational number `r = a/b` is `x^(a/b) = root(x^a, b)`, where `root(p, q)` is the `q`th root of `p`.
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({n, d}) do
    gcd = Integer.gcd(n, d)
    if d > 0 do
      {div(n, gcd), div(d, gcd)}
    else
      {-div(n, gcd), -div(d, gcd)}
    end
  end
end
