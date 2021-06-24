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

    it 'becomes false after placed ship' do
      @cell.place_ship(@ship)

      expect(@cell.empty?).to eq false
    end

    it 'does not become false after fired upon' do
      @cell.place_ship(@ship)
      @cell.fire_on

      expect(@cell.empty?).to eq false
    end
  end

  describe '#place ship' do
    it 'updates ship ivar' do
      @cell.place_ship(@ship)

      expect(@cell.ship).to eq @ship
    end

    it 'does not place if cell is full' do
      @cell.place_ship(@ship)
      ship_2 = Ship.new('Destroyer', 4)

      expect(@cell.place_ship(ship_2)).to eq false
      expect(@cell.ship).to eq @ship
    end
  end

  describe '#fired_upon?' do
    it 'starts as false' do
      expect(@cell.fired_upon?).to eq false
    end

    it 'becomes true when fired upon' do
      @cell.fire_on

      expect(@cell.fired_upon?).to eq true
    end

  end

  describe '#fire_on' do
    it 'changes fired upon ivar' do
      @cell.fire_on
    end

    it 'cannot fire if already fired on' do
      @cell.fire_on

      expect(@cell.fired_upon?).to eq true
      expect(@cell.fire_on).to eq 'Already Fired Here!'
    end

    it 'damages any ships in cell' do
      @cell.place_ship(@ship)

      expect(@ship.health).to eq 3

      @cell.fire_on

      expect(@ship.health).to eq 2
    end
  end
end
