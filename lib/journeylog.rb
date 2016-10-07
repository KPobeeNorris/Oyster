require_relative 'station'
require_relative 'journey'

class JourneyLog

  attr_reader :current, :journey_history, :fare, :current_journey

  def initialize
    reset_current_journey
    @journey_history = []

  end

  def reset_current_journey
    @current = Journey.new
  end

  def start_journey(station)
    if @current.current_journey[:exit_station] == nil && @current.current_journey[:entry_station] != nil
      record_journey_history
    end
    start_clear_journey(station)
  end

  def start_clear_journey(station)
    reset_current_journey
    @current.current_journey[:entry_station] = station.name
    @current.current_journey[:entry_zone] = station.zone
  end

  def end_journey(station)
    @current.current_journey[:exit_station] = station.name
    @current.current_journey[:exit_zone] = station.zone
    record_journey_history
  end

  def record_journey_history
    @journey_history << @current.current_journey
  end

end
