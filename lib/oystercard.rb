require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_accessor :balance, :history
  # attr_reader MINIMUM_BALANCE

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def deduct_fare
    @balance-= FARE
  end

end
