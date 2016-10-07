require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :history, :current_journey


  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @current_journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil}
  end

  def touch_in(station)
    reset_current_journey
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @current_journey[:entry_station] = station.name
    @current_journey[:entry_zone] = station.zone
  end

  def touch_out(station)
    @current_journey[:exit_station] = station.name
    @current_journey[:exit_zone] = station.zone
    deduct_fare
    record_journey_history

  end

  def record_journey_history
    @journey_history << @current_journey
  end

  def reset_current_journey
    @current_journey = {entry_station: nil, exit_station: nil, entry_zone: nil, exit_zone: nil}
  end

  def top_up(money)
    fail "Card limit is #{MONEY_LIMIT}." if money + @balance > MONEY_LIMIT
    @balance += money
  end

  def deduct_fare
    @balance-= FARE
  end

end
