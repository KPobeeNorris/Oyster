class Oystercard

  attr_reader :balance

  MONEY_LIMIT = 90


  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def deduct(fare)
    @balance-= fare
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
