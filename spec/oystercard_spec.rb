require 'oystercard'

describe Oystercard do
  it 'have balance' do
    expect(subject).to respond_to :balance
  end
end
