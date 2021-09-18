defmodule Secrets do
  def secret_add(secret) do
    fn addend -> addend + secret end
  end

  def secret_subtract(secret) do
    fn minuend -> minuend - secret end
  end

  def secret_multiply(secret) do
    fn factor -> factor * secret end
  end

  def secret_divide(secret) do
    fn divident -> div(divident, secret) end
  end

  def secret_and(secret) do
    fn operand -> Bitwise.band(operand, secret) end
  end

  def secret_xor(secret) do
    fn operand -> Bitwise.bxor(operand, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn operand -> operand |> secret_function1.() |> secret_function2.() end
  end
end
