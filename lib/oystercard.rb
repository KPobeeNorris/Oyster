require_relative 'station'

class Oystercard

  attr_reader :balance, :entry_station, :history

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1


  def initialize
    @balance = 0
    @history = []
    @current_journey = []
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @entry_station = station
    if !@current_journey.empty? == 1
      @current_journey << {exit_station: "INCOMPLETE"}
      @history << @current_journey
      @current_journey << {entry_station: station}
    else
      @current_journey << {entry_station: station}
    end
  end

  def touch_out(station)
    deduct(FARE)
    if @current_journey.empty?
      @current_journey << {entry_station: "INCOMPLETE"}
      @current_journey << {exit_station: station.to_s}
      @history << @current_journey
      @current_journey = []
    else
      @current_journey << {exit_station: station.to_s}
      @history << @current_journey
      @current_journey = []
    end
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
