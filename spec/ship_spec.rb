require './lib/ship'

describe Ship do
  it 'exists' do
    cruiser = Ship.new('Cruiser', 3)

    expect(cruiser).is_a? Ship
  end
end