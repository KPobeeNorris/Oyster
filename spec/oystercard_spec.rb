require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

    before do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
    end

  #, balance => Oystercard::MINIMUM_BALANCE
  let(:station) {double :station}

  context 'balance' do
    it 'have balance' do
      expect(card).to respond_to :balance
    end
  end

  context '#top up' do

    it 'limits top up value MONEY_LIMIT' do
      card.top_up(Oystercard::MONEY_LIMIT - 1)
      expect{card.top_up(1)}.to raise_error "Card limit is #{Oystercard::MONEY_LIMIT}."
    end

  end

  context '#money coming off card' do

    it 'deducts fare per journey' do
      card.touch_in(station)
      card.touch_out(station)
      expect(card.balance).to eq Oystercard::MINIMUM_BALANCE - Oystercard::FARE
    end

  end

  context 'touching in and out' do

    it 'raises error if card below minimum balance when touching in' do
      card.top_up(-1)
      expect{card.touch_in(station)}.to raise_error "Insufficient funds for journey"
    end

    it 'charges the card on touch out' do
      card.touch_in(station)
      expect{card.touch_out(station)}.to change{card.balance}.by(-Oystercard::FARE)
    end
  end

  

end
