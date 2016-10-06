require_relative 'oystercard'
require_relative 'station'

class Journey

  attr_reader :current_journey

  def initialize
    @current_journey = {entry: nil, exit: nil}
  end

  def touch_in(station, card)
    #touch_in(station, card = card)
    fail "Insufficient funds for journey" if card::balance < Oystercard::MINIMUM_BALANCE
    @current_journey[:entry] = station
  end

  def touch_out(station, card)
    @current_journey[:exit] = station
    card::deduct_fare
    card::history << @current_journey
    @current_journey = {entry: nil, exit: nil}
  end

  def in_journey?
    return false if @current_journey[:entry] == nil
    true
  end

  private

end
