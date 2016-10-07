require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard

  attr_reader :balance, :journey


  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 20
    @journey = JourneyLog.new
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    incomplete_journey
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.end_journey(station)
    deduct(@journey.current.fare)
  end


  def top_up(money)
    fail "Card limit is #{MONEY_LIMIT}." if money + @balance > MONEY_LIMIT
    @balance += money
  end

  def incomplete_journey
    if @journey.current.current_journey[:entry_station] != nil && @journey.current.current_journey[:exit_station] == nil
      deduct(@journey.current.fare)
      record_and_reset
    end
  end

  def deduct(fare)
      @balance -= fare
  end

  def record_and_reset
    @journey.record_journey_history
    @journey.reset_current_journey
  end
end
