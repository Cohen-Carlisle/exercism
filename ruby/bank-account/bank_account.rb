class BankAccount
  def open
    raise_if_open
    self.open = true
    self.balance = 0
  end

  def close
    raise_unless_open
    self.open = false
  end

  def balance
    raise_unless_open
    @balance
  end

  def deposit(amount)
    raise_unless_open
    raise_if_negative(amount)
    self.balance += amount
  end

  def withdraw(amount)
    raise_unless_open
    raise_if_negative(amount)
    raise_if_overdraw(amount)
    self.balance -= amount
  end

  private

  def raise_unless_open
    raise ArgumentError, "Cannot perform operation on a closed account" unless open?
  end

  def raise_if_open
    raise ArgumentError, "Cannot perform operation on an open account" if open?
  end

  def raise_if_negative(amount)
    raise ArgumentError, "Cannot deposit or withdraw a negative amount" if amount < 0
  end

  def raise_if_overdraw(amount)
    raise ArgumentError, "Cannot overdraw account" if amount > balance
  end

  attr_writer :balance
  attr_writer :open

  def open?
    @open
  end
end
