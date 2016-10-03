require 'oystercard'

describe Oystercard do
  it 'have balance' do
    expect(subject).to respond_to :balance
  end

  describe '#top up' do

    describe 'tops up method exists'
    it {is_expected.to respond_to :top_up}

    describe 'top_up adds money'
    oystercard = Oystercard.new
    oystercard.top_up(10)
    it {expect(oystercard.balance).to eq 10}
  end

end
