require_relative 'oystercard'
require_relative 'station'

class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :current_journey, :journey_history, :fare

  def initialize
    @journey_history = []
    @current_journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil}
  end

  def start_journey(station)
    if @current_journey[:exit_station] == nil && @current_journey[:entry_station] != nil
      record_journey_history
    end
    start_clear_journey(station)
  end

  def start_clear_journey(station)
    reset_current_journey
    @current_journey[:entry_station] = station.name
    @current_journey[:entry_zone] = station.zone
  end

  def end_journey(station)
    @current_journey[:exit_station] = station.name
    @current_journey[:exit_zone] = station.zone
    record_journey_history
  end

  def record_journey_history
    @journey_history << @current_journey
  end

  def reset_current_journey
    @current_journey = {entry_station: nil, exit_station: nil, entry_zone: nil, exit_zone: nil}
  end

  def fare
    if @current_journey[:entry_station] == nil || @current_journey[:exit_station] == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

  private

end
