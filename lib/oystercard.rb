require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :history,
              :current_journey

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1


  def initialize
    @balance = 0
    @current_journey = {entry: nil, exit: nil}
    @history = []
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @entry_station = station
    @current_journey[:entry] = station
  end

  def touch_out(station)
    deduct(FARE)
    @current_journey[:exit] = station
    @entry_station = nil
    @history << current_journey
    # @current_journey = {entry: nil, exit: nil}
  end




private

  def deduct(fare)
    @balance-= fare
  end

end
