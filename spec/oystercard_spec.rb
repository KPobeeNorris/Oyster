require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  #, balance => Oystercard::MINIMUM_BALANCE
  let(:mudchute) {double :station}
  let(:bank)     {double :station}

  context 'balance' do
    it 'have balance' do
      expect(card).to respond_to :balance
    end
  end

  context '#top up' do

    describe 'tops up method exists'
    it {is_expected.to respond_to :top_up}

    it 'top_up adds money' do
    card.top_up(10)
    expect(card.balance).to eq 10
    end

    it 'limits top up value MONEY_LIMIT' do
      card.top_up(Oystercard::MONEY_LIMIT)
      expect{card.top_up(1)}.to raise_error "Card limit is #{Oystercard::MONEY_LIMIT}."
    end

  end

  context '#money coming off card' do

    it 'deducts fare per journey' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in
      card.touch_out
      expect(card.balance).to eq Oystercard::MINIMUM_BALANCE - Oystercard::FARE
    end

  end

  context 'touching in and out' do

    it 'responds to in_journey' do
      expect(card.in_journey?).to eq(true).or eq(false)
    end

    it 'touching in registers that the card is in journey' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in
      expect(card.in_journey?).to eq true
    end

    it 'raises error if card below minimum balance when touching in' do
      card.top_up(Oystercard::MINIMUM_BALANCE - 1)
      expect{card.touch_in}.to raise_error "Insufficient funds for journey"
    end

    it 'touching out registers the card as no longer being in journey' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in
      card.touch_out
      expect(card.in_journey?).to eq false
    end

    it 'charges the card on touch out' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in
      expect{card.touch_out}.to change{card.balance}.by(-Oystercard::FARE)
    end
  end

  context 'journey status and history' do

    it 'records the entry station on touch in' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in(mudchute)
      expect(card.entry_station).to eq mudchute
    end

  end

end
