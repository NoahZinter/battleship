require './lib/ship'
require './lib/cell'

describe Cell do
  before(:each) do
    @cell = Cell.new('B3')
    @ship = Ship.new('Cruiser', 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).is_a? Cell
    end

    it 'has a coordinate' do
      expect(@cell.coordinate).to eq 'B3'
    end

    it 'starts with no ship' do
      expect(@cell.ship).to eq nil
    end
  end

  describe '#empty?' do
    it 'starts as true' do
      expect(@cell.empty?).to eq true
    end

    it 'becomes false after placed ship'

    it 'does not become false after fired upon'
  end

  describe '#place ship' do
    it 'updates ship ivar' do
      @cell.place_ship(@ship)

      expect(@cell.ship).to eq @ship
    end
  end
end
