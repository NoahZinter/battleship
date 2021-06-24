require './lib/ship'

describe Ship do
  before(:each) do
    @cruiser = Ship.new('Cruiser', 3)
  end
  it 'exists' do
    expect(@cruiser).is_a? Ship
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
end