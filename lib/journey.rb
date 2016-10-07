require_relative 'oystercard'
require_relative 'station'

class Journey

  attr_reader :current_journey

  def initialize
  end



  def in_journey?
    return false if @current_journey[:entry] == nil
    true
  end

  private

end
