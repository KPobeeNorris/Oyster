require 'journey'
require 'oystercard'
require 'station'

describe Journey do
  subject(:journey) {described_class.new}


    station = Station.new
    card = Oystercard.new
    card.top_up(10)


  # let(:station) {double :station}
  # let(:card) {double :card}

  context 'starting and finishing' do

    it 'responds to in_journey' do
      expect(journey.in_journey?).to eq(true).or eq(false)
    end

  end

  context 'current journey info' do

    it 'touching in registers that the card is in journey' do
      card.touch_in(station)
      expect(journey.in_journey?).to eq true
    end


    it 'touching out registers the card as no longer being in journey' do
      card.touch_in(station)
      card.touch_out(station)
      expect(journey.in_journey?).to eq false
    end

  end

  context 'journey status and history' do

    it 'records the entry station on touch in' do
      card.touch_in(station)
      expect(journey.entry_station).to eq station
    end

    it 'expects entry station to be nil after touch out' do
      card.touch_in(station)
      card.touch_out(station)
      expect(journey.entry_station). to eq nil
    end

    it 'stores entry station in current journey on touch in' do
      card.touch_in(station)
      expect(journey.current_journey).to include entry: station, exit: nil
    end



  end

end
