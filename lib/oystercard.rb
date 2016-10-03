class Oystercard

attr_reader :balance

MONEY_LIMIT = 90


def initialize
  @balance = 0
end

def top_up(money)
  fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
  @balance += money
end

end
