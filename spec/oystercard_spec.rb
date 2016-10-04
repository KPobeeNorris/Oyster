require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

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

    it 'deducts money' do
      expect(card).to respond_to :deduct
    end

    it 'deducts (fare(£2)) per journey' do
      card.top_up(10)
      card.deduct(2)
      expect(card.balance).to eq 8
    end

  end

  context 'touching in and out' do

    it 'responds to in_journey' do
      expect(card.in_journey?).to eq(true).or eq(false)
    end

    it 'touching in registers that the card is in journey' do
      card.touch_in
      expect(card.in_journey?).to eq true
    end

    it 'touching out registers the card as no longer being in journey' do
      card.touch_in
      card.touch_out
      expect(card.in_journey?).to eq false
    end

  end




end
