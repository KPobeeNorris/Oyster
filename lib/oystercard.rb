require_relative 'station'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :history,
              :current_journey

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1


  def initialize
    @balance = 0
    @current_journey = []
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @entry_station = station
    @current_journey << {entry: station, exit: nil}
  end

  def touch_out(station)
    deduct(FARE)
    @exit_station = station
    @entry_station = nil

  end

  def in_journey?
    return false if @entry_station == nil
    true
  end


private

  def deduct(fare)
    @balance-= fare
  end

end
