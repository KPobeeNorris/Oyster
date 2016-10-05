class Station

  def initialize
    station_info_list = [{station:"brixton", zone: 2}, {station:"bank", zone: 1},
      {station:"cockfosters", zone: 4}, {station:"holborn", zone: 1}]

    @station_info = station_info_list[rand(station_info_list.length)]
  end

end
