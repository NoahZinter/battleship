require './lib/ship'

describe Ship do
  before(:each) do
    @cruiser = Ship.new('Cruiser', 3)
  end
  describe '#initialize' do
    it 'exists' do
      expect(@cruiser).is_a? Ship
    end
  end

  describe 'attributes' do
    it 'has a name' do
      expect(@cruiser.name).to eq 'Cruiser'
    end

    it 'has a length' do
      expect(@cruiser.length).to eq 3
    end

    it 'has health equal to length' do
      expect(@cruiser.health).to eq 3
    end
  end

  describe '#hit' do
    it 'reduces health by one' do
      @cruiser.hit

      expect(@cruiser.health).to eq 2
    end

    it 'does not change length' do
      @cruiser.hit

      expect(@cruiser.health).to eq 2
      expect(@cruiser.length).to eq 3
    end

    it 'cannot go below 0 health' do
      3.times { @cruiser.hit }

      expect(@cruiser.health).to eq 0
      expect(@cruiser.hit).to eq 'Ship Already Sunk!'

      @cruiser.hit

      expect(@cruiser.health).to eq 0
    end
  end

  describe '#sunk?' do
    it 'starts as false' do
      expect(@cruiser.sunk?).to eq false
    end

    it 'becomes true when health is out' do
      3.times { @cruiser.hit }

      expect(@cruiser.sunk?).to eq true
    end
  end
end
