require_relative 'oystercard'
require_relative 'station'

class Journey

  def in_journey?
    return false if @entry_station == nil
    true
  end

end
