require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey


  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 20
    @journey = Journey.new
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @journey.start_journey(station)
    if @journey.journey_history.last[:exit_station] == nil
      @balance -= PENALTY_FARE
    end
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

  def deduct
      @balance-= FARE
  end

end
