require 'oystercard'

describe Oystercard do
  it 'have balance' do
    expect(subject).to respond_to :balance
  end

  describe '#top up' do

    describe 'tops up method exists'
    it {is_expected.to respond_to :top_up}

    it 'top_up adds money' do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
    end

    it 'limits top up value to £90' do
      oystercard = Oystercard.new
      expect{oystercard.top_up(91)}.to raise_error "Card limit is #{Oystercard::MONEY_LIMIT}."
    end
  end

  describe '#money coming off card' do

    it 'deducts money' do
      oystercard = Oystercard.new
      expect(oystercard).to respond_to :deduct
    end

    it 'deducts £2 per journey' do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      oystercard.deduct(2)
      expect(oystercard.balance).to eq 8
    end

  end

end
