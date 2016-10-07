require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey


  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 5
    @journey = Journey.new
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.end_journey(station)
    deduct_fare
    [station.name, station.zone, FARE, @balance]
  end


  def top_up(money)
    fail "Card limit is #{MONEY_LIMIT}." if money + @balance > MONEY_LIMIT
    @balance += money
  end

  def deduct_fare
    @balance-= FARE
  end

end
