require 'station'

describe Station do

  context 'initialization' do

    it 'a new station has a name' do
      stat = Station.new
      expect(stat.name).to eq "brixton"
    end

    it 'a new station has a zone' do
      stat = Station.new
      expect(stat.zone).to eq 2
    end


  end


end
