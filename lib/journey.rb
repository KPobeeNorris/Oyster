require_relative 'oystercard'
require_relative 'station'

class Journey

  attr_reader :current_journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @current_journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil}
  end

  def fare
    if @current_journey[:entry_station] == nil || @current_journey[:exit_station] == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

end
